class db.MemberView extends Marionette.CompositeView
  template: ich.member
  className: 'member-view'
  templateHelpers: ->
    is_admin: db.admin
    member_info: @_build_member_info
    nickname: @_get_member_name
    has_emergency_contacts: @_has_emergency_contacts
    emergency_contacts: @_build_emergency_contacts
    has_player_profiles: @_has_player_profiles
    player_profiles: @_build_player_profiles

  # Max length of text type in MySQL
  MYSQL_MAXLENGTH: 65535

  #Attributes on the Member model that don't need rows in the table
  IGNORED_MEMBER_HEADERS: ['id', 'emergency_contacts', 'players']

  #Attributes on the Emergency Contact model that don't need rows in the table(s)
  IGNORED_EMERGENCY_CONTACT_HEADERS: ['id', 'member_id']

  #Attributes on the Player model that need rows in the table(s)
  PLAYER_PROFILE_HEADERS: ['name', 'number', 'date_started', 'date_ended', 'active', 'id']

  # Attributes on the model that need larger text boxes and character limits
  TEXTAREA_ATTRIBUTES: ['reason_left', 'address']

  DATEPICKER_ATTRIBUTES: ['date_of_birth', 'date_started', 'date_ended']

  #Attributes on the Member model that have boolean values
  BOOLEAN_EDIT_BOXES: ['signed_wftda_waiver', 'signed_wftda_confidentiality',
  'signed_league_bylaws', 'purchased_wftda_insurance', 'passed_wftda_test',
  'active', 'google_doc_access', 'volunteer', 'official']

  events: ->
    'click button.edit':                         '_show_edit_table'
    'click button.create':                       '_show_create_table'
    'click button.save:not(.disabled)':          '_handle_edit_save'
    'click button.create-save:not(.disabled)':   '_handle_create_save'
    'click button.cancel':                       '_render'
    'click td.link':                             '_handle_tdlink_click'
    'change input':                              '_handle_input_change' # datepicker
    'input input':                               '_handle_input_change'
    'keydown input':                             '_handle_input_change'
    'input textarea':                            '_handle_input_change'
    'keydown textarea':                          '_handle_input_change'
    'change select':                             '_handle_select_change'
    'focus td input':                            '_handle_td_input_focus'
    'focus td select':                           '_handle_td_input_focus'
    'focus td textarea':                         '_handle_td_input_focus'
    'blur td input':                             '_handle_td_input_blur'
    'blur td select':                            '_handle_td_input_blur'
    'blur td textarea':                          '_handle_td_input_blur'

  initialize: ->
    @players = new db.PlayersCollection(db.players.where({member_id: @model.id}))
    @emergency_contacts = new db.EmergencyContactsCollection(
      db.emergency_contacts.where({member_id: @model.id}))

  onShow: =>
    @_prepare_edit_tables()
    @_prepare_create_tables()

  _render: =>
    @render()
    @onShow()
    @_generate_phone_mask()

  _prepare_edit_tables: ->
    @_limit_input_length()
    @_transform_textareas()
    @_transform_boolean_inputs()
    @_select_player_active_options()
    @_generate_datepickers()
    @_generate_phone_mask()
    @_generate_wftda_id_mask()
    @_generate_player_number()
    @_generate_year_masks()
    @_disable_timestamps()

  _prepare_create_tables: ->
    @_fill_team_dropdowns()

  # Event handlers and their helpers

  _show_edit_table: (e) ->
    view = $(e.currentTarget).parents('.view')
    $(view).find('table.show').hide()
    $(view).find('button.edit').hide()
    $(view).find('button.create').hide()
    $(view).find('table.edit').show()
    $(view).find('.edited').removeClass('edited')
    $(view).find('.text-primary').removeClass('text-primary')
    $(view).find('.edit-table-buttons').show()
    $(view).find('.edit-table-buttons > .save').addClass('disabled')

  _show_create_table: (e) ->
    view = $(e.currentTarget).parents('.view')
    $(view).find('button.save').addClass('create-save')
    $(view).find('button.edit').hide()
    $(view).find('button.create').hide()
    $(view).find('table.create').show()
    $(view).find('.create-table-buttons').show()
    $(view).find('.create-table-buttons > .save').addClass('disabled')
    if $(e.currentTarget).attr('class').indexOf('first') > -1
      $(window).scrollTop($(window).scrollTop()+130)

  _handle_input_change: (e) ->
    $(e.currentTarget).addClass('text-primary')
    @_handle_field_change(e)

  _handle_select_change: (e) ->
    $(e.currentTarget).parents('td').addClass('text-primary')
    @_handle_field_change(e)

  _handle_field_change: (e) ->
    $(e.currentTarget).parents('tr').addClass('edited')
    $(e.currentTarget).removeClass('error')
    $(e.currentTarget).parents('.view').find('button.save').removeClass('disabled')

  _handle_td_input_focus: (e) ->
    tr = $(e.currentTarget).parents('tr')
    tr.addClass('focus')

  _handle_td_input_blur: (e) ->
    tr = $(e.currentTarget).parents('tr')
    tr.removeClass('focus')

  _handle_edit_save: (e) =>
    tables = $(e.currentTarget).parents('.view').find('table.edit')
    data_els = $(tables).find('.edited .cell')
    if db.TableValidator.table_is_valid(data_els)
      if ($(e.currentTarget).attr('class')).indexOf('member') > -1
        data = @_get_member_edit_table_data(data_els)
        @_submit_member(data, e)
      else if ($(e.currentTarget).attr('class')).indexOf('player') > -1
        player_data = @_get_player_edit_table_data(tables.find('tr.data.edited'))
        @_submit_players(player_data, e)
      else
        emergency_contact_data = @_get_emergency_contact_edit_table_data(tables)
        @_submit_updated_emergency_contacts(emergency_contact_data, e)

  _handle_create_save: (e) ->
    view_classes = $(e.currentTarget).parents('.view').attr('class')
    if view_classes.indexOf('player') > -1
      if @_should_create_player()
        data = @_get_player_create_table_data()
        @_submit_new_player(data)
      else
        @_set_errors_on_new_player()
    else if view_classes.indexOf('emergency-contact') > -1
      if @_should_create_emergency_contact()
        data = @_get_emergency_contact_create_table_data()
        @_submit_new_emergency_contact(data)
      else
        @_set_errors_on_new_emergency_contacts()

  _set_errors_on_new_emergency_contacts: ->
    $('.emergency-contact table.create input[data-attribute=name]').addClass('error')

  _set_errors_on_new_player: ->
    _.each ['name', 'number'], (attr) ->
      if $(".player table.create input[data-attribute=#{attr}]").val().length == 0
        $(".player table.create input[data-attribute=#{attr}]").addClass('error')

  _should_create_player: ->
    name = !!$('.player table.create input[data-attribute="name"]').val().length
    number = !!$('.player table.create input[data-attribute="number"]').val().length
    return name && number

  _should_create_emergency_contact: ->
    return !!$('.emergency-contact table.create input[data-attribute="name"]').val().length

  _submit_member: (data, e) ->
    new db.Member().save data,
      success: (model) => @_handle_member_submit_success(e, model)

  _submit_players: (player_data, e) =>
    _.each player_data, (player) =>
      new db.Player().save player,
        success: (model) => @_handle_player_submit_success(e, model),

  _submit_updated_emergency_contacts: (emergency_contact_data, e) ->
    _.each emergency_contact_data, (emergency_contact) =>
      new db.EmergencyContact().save emergency_contact,
        success: (model) => @_handle_emergency_contact_submit_success(e, model)

  _submit_new_emergency_contact: (data) =>
    new db.EmergencyContact().save data,
      success: (model) => @_handle_emergency_contact_create_success(model)

  _submit_new_player: (data) =>
    new db.Player().save data,
      success: (model) => @_handle_player_create_success(model)

  _handle_member_submit_success: (e, member) =>
    @model = member
    db.members.add(member, {merge: true})
    @_render()

  _handle_player_submit_success: (e, player) =>
    db.players.add(player, {merge: true})
    @_render()

  _handle_emergency_contact_submit_success: (e, emergency_contact) =>
    db.emergency_contacts.add(emergency_contact, {merge: true})
    @_render()

  _handle_emergency_contact_create_success: (emergency_contact) =>
    db.emergency_contacts.add(emergency_contact)
    @emergency_contacts.add(emergency_contact)
    @_render()

   _handle_player_create_success: (player) =>
    db.players.add(player)
    @players.add(player)
    delete @player_profiles
    @_render()

  _handle_tdlink_click: (e) ->
    id = $(e.currentTarget).data('id')
    db.app.Router.navigate("teams/#{id}", {trigger: true})

  # Data cleaning methods

  _build_member_info: =>
    attrs = []
    _.each @model.attributes, (v, k) =>
      attrs.push [k,v]

    attrs = attrs.sort(db.Helpers.attributes_comparator)

    _.compact _.map attrs, (obj) =>
      unless _.contains @IGNORED_MEMBER_HEADERS, obj[0]
        attribute = db.Helpers.map_header obj[0]
        model_attribute = obj[0]
        value = db.Helpers.clean_table_value obj[1]
        {attribute: attribute, value: value, model_attribute: model_attribute}

  _build_emergency_contacts: =>
    if @emergency_contacts.length > 0
      _.map @emergency_contacts.models, (e) =>
        { id: e.id, emergency_contact_info: @_get_emergency_contact_info(e) }

  _get_emergency_contact_info: (e) =>
    _.compact _.map e.attributes, (v, k) =>
      unless _.contains @IGNORED_EMERGENCY_CONTACT_HEADERS, k
        attribute = db.Helpers.map_header k
        model_attribute = k
        value = db.Helpers.clean_table_value v
        {attribute: attribute, value: value, model_attribute: model_attribute}

  _build_player_profiles: =>
    unless @player_profiles
      @player_profiles = _.map @players.models, (player) => @_build_profile_row(player)
    return @player_profiles

  _build_profile_row: (player) ->
    team_id = player.get('team_id')
    team_name  = if team_id then db.teams.get(team_id).get('name') else ''
    row = {team_name: team_name, team_id: team_id}
    _.each @PLAYER_PROFILE_HEADERS, (h) =>
      value = db.Helpers.clean_table_value player.get(h)
      row[h] = value
    row

  # Accessors

  _get_member_name: =>
    @model.get('nickname')

  _has_emergency_contacts: =>
    @emergency_contacts.length > 0

  _has_player_profiles: =>
    @players.length > 0

  _fill_team_dropdowns: ->
    _.each db.teams.models, (team) ->
      $('table.create select.teams').append($('<option>', {
        value: team.get('id'),
        text: team.get('name')
      }))

  # Edit table modifications
  #   Some fields on the edit table need to have extra attributes added to them
  #   for weak front-end validation. these methods will do that.

  _limit_input_length: ->
    # Every input field except those below have MySQL max text lengths of 255
    # Some input fields (e.g. year joined) may have even stricter validations
    $('input').attr('maxlength', 255)

  _transform_textareas: ->
    # Any attributes that should be textareas need to be transformed
    _.each @TEXTAREA_ATTRIBUTES, (attr) =>
      _.each $("td[data-attribute='#{attr}']"), (cell) ->
        value = $(cell).text()
        $(cell).parents('td .border-div').html(
          "<textarea data-attribute='#{attr}' maxlength=#{@MYSQL_MAXLENGTH}>
          </textarea>")

        $(cell).val(value).addClass('cell')

  _transform_boolean_inputs: ->
    # Any attributes that are strictly boolean need to be transformed to
    # dropdowns.
    _.each @BOOLEAN_EDIT_BOXES, (attr) =>
      _.each $("input[data-attribute='#{attr}']"), (cell) =>
        value = $(cell).attr('value')
        parent = $(cell).parent()
        $(parent).html(
          "<select data-attribute='#{attr}'>
          <option value=''></option>
          <option value='true'>✓</option>
          <option value='false'>✗</option>
          </select>")

        $(parent).find('select').val(@_symbol_to_bool(value)).addClass('cell')

  _select_player_active_options: ->
    # We don't create these dymanically - they're in the haml. But they need
    # to be properly selected on render, so we do that here.
    _.each $('.player.edit select[data-attribute=active]'), (elem) =>
      $(elem).val(@_symbol_to_bool($(elem).attr('value')))

  _generate_datepickers: ->
    _.each @DATEPICKER_ATTRIBUTES, (attr) ->
      $("[data-attribute=#{attr}]").datepicker({
          format: 'yyyy-mm-dd',
          orientation: 'bottom left',
          startDate: '-100y'
      }).attr('placeholder', 'yyyy-mm-dd')
        .mask('9999-99-99',{placeholder:'yyyy-mm-dd'})

  _generate_phone_mask: ->
    $("input[data-attribute='phone_number']").mask('(999) 999-9999')
      .attr('placeholder', '(999) 999-9999')

   _generate_wftda_id_mask: ->
    $("input[data-attribute='wftda_id_number']").mask('99999?9')

   _generate_player_number: ->
    $("input[data-attribute='number']").mask('9?999')

   _generate_year_masks: ->
    $("input[data-attribute='year_left']").mask('9999', {placeholder: 'yyyy'})
      .attr('placeholder', 'yyyy')
    $("input[data-attribute='year_joined']").mask('9999', {placeholder: 'yyyy'})
      .attr('placeholder', 'yyyy')

  _disable_timestamps: ->
    # Timestamp rows are automatically maintained by Rails, not by users
    $("[data-attribute=created_at]").prop('disabled', true).removeClass('cell')
    $("[data-attribute=updated_at]").prop('disabled', true).removeClass('cell')

  # Table data accessor methods

  _get_member_edit_table_data: (els) ->
    attrs = id: @model.get('id')
    _.each els, (el) =>
      key = $(el).data('attribute')
      value = @_get_data_from_input(el)
      attrs[key] = value
    return attrs

  _get_player_edit_table_data: (rows) ->
    return _.map rows, (row, idx) =>
      attrs = id: $(row).data('player-id')
      cells = $(row).find('.cell')
      _.each cells, (cell) =>
        key = $(cell).data('attribute')
        value = @_get_data_from_input(cell)
        attrs[key] = value
      return attrs

  _get_emergency_contact_edit_table_data: (tables) ->
    return _.map tables, (table, idx) =>
      attrs = id: $(table).data('emergency-contact-id')
      cells = $(table).find('.cell')
      _.each cells, (cell) =>
        key = $(cell).data('attribute')
        value = @_get_data_from_input(cell)
        attrs[key] = value
      return attrs

  _get_player_create_table_data: ->
    data = {member_id: @model.id}
    _.each $('.player table.create').find('select, input'), (cell) ->
      attr = $(cell).attr('data-attribute')
      val = $(cell).val()
      data[attr] = val
    data

  _get_emergency_contact_create_table_data: ->
    data = {member_id: @model.id}
    _.each $('.emergency-contact table.create input'), (cell) ->
      attr = $(cell).attr('data-attribute')
      val = $(cell).val()
      data[attr] = val
    data

  _get_data_from_input: (i) ->
    $(i).value?() || $(i).val?()

  _bool_to_symbol: (value) ->
    if value == 'true'
      '✓'
    else if value == 'false'
      '✗'
    else
      ''

  _symbol_to_bool: (value) ->
    if value == '✓'
      'true'
    else if value == '✗'
      'false'
    else
      'null'
