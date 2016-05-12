class db.MemberView extends Marionette.CompositeView
  template: ich.member
  className: 'member-view'
  templateHelpers: ->
    member_info: @_build_member_info
    nickname: @_get_member_name
    has_emergency_contacts: @_has_emergency_contacts
    emergency_contacts: @_build_emergency_contacts
    has_player_profiles: @_has_player_profiles
    player_profiles: @_build_player_profiles

  # Max length of text type in MySQL
  MYSQL_MAXLENGTH: 65535

  #Attributes on the Member model that don't need rows in the table
  IGNORED_MEMBER_HEADERS: ['nickname', 'id', 'emergency_contacts', 'players']

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
  'active', 'google_doc_access']

  events: ->
    'click button.edit':                '_show_edit_table'
    'click button.save:not(.disabled)': '_handle_save'
    'click button.cancel':              '_handle_cancel'
    'click td.link':                    '_handle_tdlink_click'
    'change input':                     '_handle_input_change' # datepicker
    'input input':                      '_handle_input_change'
    'input textarea':                   '_handle_input_change'
    'change select':                    '_handle_select_change'
    'focus td input':                   '_handle_td_input_focus'
    'focus td select':                  '_handle_td_input_focus'
    'focus td textarea':                '_handle_td_input_focus'
    'blur td input':                    '_handle_td_input_blur'
    'blur td select':                   '_handle_td_input_blur'
    'blur td textarea':                 '_handle_td_input_blur'

  onShow: =>
    @_prepare_edit_tables()

  _prepare_edit_tables: ->
    @_limit_input_length()
    @_transform_textareas()
    @_transform_boolean_inputs()
    @_select_player_active_options()
    @_generate_datepickers()
    @_generate_phone_mask()
    @_generate_wftda_id_mask()
    @_generate_year_masks()
    @_disable_timestamps()

  # Event handlers and their helpers

  _show_view_table: (e) ->
    view = $(e.currentTarget).parents('.view')
    $(view).find('table.show').show()
    $(view).find('button.edit').show()
    $(view).find('table.edit').hide()
    $(view).find('.edit-table-buttons').hide()

  _show_edit_table: (e) ->
    view = $(e.currentTarget).parents('.view')
    $(view).find('table.show').hide()
    $(view).find('button.edit').hide()
    $(view).find('table.edit').show()
    $(view).find('.edited').removeClass('edited')
    $(view).find('.text-primary').removeClass('text-primary')
    $(view).find('.edit-table-buttons').show()
    $(view).find('.edit-table-buttons > .save').addClass('disabled')

  _reset_edit_table: (e) ->
    table = $(e.currentTarget).parents('.view').find('table.edit')
    _.each @model.attributes, (val, attr) =>
      if _.contains @BOOLEAN_EDIT_BOXES, attr
        $(table).find("select[data-attribute='#{attr}']").val("#{val}")
      else
        $(table).find("input[data-attribute='#{attr}']").val(val)

  _update_member_view_table: (e) ->
    table = $(e.currentTarget).parents('.view').find('table.show')
    _.each @model.attributes, (val, attr) =>
      if _.contains @BOOLEAN_EDIT_BOXES, attr
        val = @_bool_to_symbol(val)
      $(table).find("td[data-attribute='#{attr}']").html(val)

  _update_player_view_table: (e, player_data) ->
    table = $(e.currentTarget).parents('.view').find('table.show')
    row = $(table).find("tr[data-player-id=#{player_data.id}]")
    _.each player_data, (val, attr) =>
      if _.contains @BOOLEAN_EDIT_BOXES, attr
        val = @_bool_to_symbol(val)
      $(row).find("td[data-attribute='#{attr}']").html(val)

  _update_contact_view_table: (e, contact_data) ->
    table = $(e.currentTarget).parents('.view').
      find("table.show[data-contact-id=#{contact_data.id}]")
    _.each contact_data, (val, attr) =>
      if _.contains @BOOLEAN_EDIT_BOXES, attr
        val = @_bool_to_symbol(val)
      $(table).find("td[data-attribute='#{attr}']").html(val)

  _handle_input_change: (e) ->
    $(e.currentTarget).addClass('text-primary')
    @_handle_field_change(e)

  _handle_select_change: (e) ->
    $(e.currentTarget).parent('td').addClass('text-primary')
    @_handle_field_change(e)

  _handle_field_change: (e) ->
    $(e.currentTarget).parents('tr').addClass('edited')
    $(e.currentTarget).parent('.input').removeClass('has-danger')
    $(e.currentTarget).parents('.view').find('button.save').removeClass('disabled')

  _handle_td_input_focus: (e) ->
    tr = $(e.currentTarget).parents('tr')
    tr.addClass('focus')

  _handle_td_input_blur: (e) ->
    tr = $(e.currentTarget).parents('tr')
    tr.removeClass('focus')

  _handle_save: (e) =>
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
        contact_data = @_get_contact_edit_table_data(tables)
        @_submit_contacts(contact_data, e)

  _submit_member: (data, e) ->
    new db.Member().save data,
      success: (model) => @_handle_member_submit_success(e, model)

  _submit_players: (player_data, e) =>
    _.each player_data, (player) =>
      new db.Player().save player,
        success: () =>  @_handle_player_submit_success(e, player),
        error: (model, response) => @_handle_player_errors(player, response, e)

  _submit_contacts: (contact_data, e) ->
    _.each contact_data, (contact) =>
      new db.EmergencyContact().save contact,
        success: () => @_handle_contact_submit_success(e, contact)

  _handle_player_errors: (player, response, e) =>
    _.each response.responseJSON, (response) =>
      _.each response, (error) =>
        _.each error, (string) =>
          error_player = _.find(@model.get('players'), (p) -> return p.id == player.id)

  _handle_cancel: (e) =>
    table = $(e.currentTarget).parents('.view').find('table.edit')
    @_show_view_table(e)
    @_reset_edit_table(e)

  _handle_member_submit_success: (e, model) =>
    @model = model
    @_show_view_table(e)
    @_update_member_view_table(e)

  _handle_player_submit_success: (e, player_data) =>
    @_show_view_table(e)
    @_update_player_view_table(e, player_data)

  _handle_contact_submit_success: (e, contact_data) =>
    @_show_view_table(e)
    @_update_contact_view_table(e, contact_data)

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
    _.map @model.get('emergency_contacts'), (e) =>
      { id: e.id, contact_info: @_get_contact_info(e) }

  _get_contact_info: (e) =>
    _.compact _.map e, (v, k) =>
      unless _.contains @IGNORED_EMERGENCY_CONTACT_HEADERS, k
        attribute = db.Helpers.map_header k
        model_attribute = k
        value = db.Helpers.clean_table_value v
        {attribute: attribute, value: value, model_attribute: model_attribute}

  _build_player_profiles: =>
    a = _.flatten _.map @model.get('players'), (p) =>
      if p.teams.length > 0
        _.map p.teams, (t) =>
          @_build_profile_row(p, t)
      else
        @_build_profile_row(p, [name: null])

  _build_profile_row: (player, team) ->
    row = {team_name: team.name, team_id: team.id}
    _.each @PLAYER_PROFILE_HEADERS, (h) =>
      value = db.Helpers.clean_table_value player[h]
      row[h] = value
    row

  # Accessors

  _get_member_name: =>
    @model.get('nickname')

  _has_emergency_contacts: =>
    @model.get('emergency_contacts').length > 0

  _has_player_profiles: =>
    @model.get('players').length > 0

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

  _get_contact_edit_table_data: (tables) ->
    return _.map tables, (table, idx) =>
      attrs = id: $(table).data('contact-id')
      cells = $(table).find('.cell')
      _.each cells, (cell) =>
        key = $(cell).data('attribute')
        value = @_get_data_from_input(cell)
        attrs[key] = value
      return attrs

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
