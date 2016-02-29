class db.MemberView extends Marionette.CompositeView
  template: ich.member
  id: 'member_view'
  templateHelpers: ->
    member_info: @_build_member_info
    name: @_get_member_name
    has_emergency_contacts: @_has_emergency_contacts
    emergency_contacts: @_build_emergency_contacts
    has_player_profiles: @_has_player_profiles
    player_profiles: @_build_player_profiles

  #Attributes on the Member model that don't need rows in the table
  IGNORED_MEMBER_HEADERS: ['name', 'id', 'emergency_contacts', 'players']

  #Attributes on the Emergency Contact model that don't need rows in the table(s)
  IGNORED_EMERGENCY_CONTACT_HEADERS: ['id', 'member_id']

  #Attributes on the Player model that don't need rows in the table(s)
  PLAYER_PROFILE_HEADERS: ['name', 'number', 'date_started', 'date_ended', 'active']

  #Attributes on the Member model that have boolean values
  BOOLEAN_EDIT_BOXES: ['Signed WFTDA Waiver', 'Signed WFTDA Confidentiality',
  'Signed League Bylaws', 'Purchased WFTDA Insurance', 'Passed WFTDA Test',
  'Active', 'Google Doc Access']

  events: ->
    'click h3.edit': '_show_edit_table'
    'click h3.save': '_handle_save'
    'change input': '_handle_input_change'

  onShow: =>
    @_prepare_edit_tables()

  _prepare_edit_tables: ->
    @_limit_input_length()
    @_transform_boolean_inputs()
    @_generate_datepickers()
    @_disable_timestamps()

  # Event handlers and their helpers

  _show_view_table: (e) ->
    view = $(e.currentTarget).parents('.view')
    $(view).find('table.show').show()
    $(view).find('h3.edit').show()
    $(view).find('table.edit').hide()
    $(view).find('h3.save').hide()

  _show_edit_table: (e) ->
    view = $(e.currentTarget).parents('.view')
    $(view).find('table.show').hide()
    $(view).find('h3.edit').hide()
    $(view).find('table.edit').show()
    $(view).find('h3.save').show()

  _handle_input_change: (e) ->
    $(e.currentTarget).parent('.input').removeClass('has-danger')

  _handle_save: (e) ->
    table = $(e.currentTarget).parents('.view').find('table.edit')
    data_els = $(table).find('td.input').children()
    if db.TableValidator.table_is_valid(data_els)
      data = @_get_edit_table_data(data_els)
      @_submit(data)

  _submit: (data) ->
    @_show_view_table(e)

  # Data cleaning methods

  _build_member_info: =>
    _.compact _.map @model.attributes, (v, k) =>
      unless _.contains @IGNORED_MEMBER_HEADERS, k
        attribute = db.Helpers.map_header k
        value = db.Helpers.clean_table_value v
        {attribute: attribute, value: value}

  _build_emergency_contacts: =>
    _.map @model.get('emergency_contacts'), (e) =>
      {contact_info:
        _.compact _.map e, (v, k) =>
          unless _.contains @IGNORED_EMERGENCY_CONTACT_HEADERS, k
            attribute = db.Helpers.map_header k
            value = db.Helpers.clean_table_value v
            {attribute: attribute,value: value}}

  _build_player_profiles: =>
    _.flatten _.map @model.get('players'), (p) =>
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
    @model.get('name')

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

    # These are text columns and MySQL can take up to 65535 chars
    $('input[data-attribute="Reason Left"]').attr('maxlength', 65535)
    $('input[data-attribute="Address"]').attr('maxlength', 65535)

  _transform_boolean_inputs: ->
    # Any attributes that are strictly boolean need to be transformed to
    # dropdowns.
    _.each @BOOLEAN_EDIT_BOXES, (attr) =>
      value = $("[data-attribute='#{attr}']").val()
      $("[data-attribute='#{attr}']").parent('td').html(
        "<select data-attribute='#{attr}'>
        <option value=''></option>
        <option value='✓'>✓</option>
        <option value='✗'>✗</option>
        </select>")
      $("[data-attribute='#{attr}']").val(value)

  _generate_datepickers: ->
    $("[data-attribute='Date Of Birth']").datepicker({
        format: 'yyyy-mm-dd',
        orientation: 'bottom left',
        startDate: '-100y',
        endDate: '-18y',
    }).attr('placeholder', 'yyyy-mm-dd');

  _disable_timestamps: ->
    # Timestamp rows are automatically maintained by Rails, not by users
    $('[data-attribute="Created"]').prop('disabled', true)
    $('[data-attribute="Updated"]').prop('disabled', true)

  # Table data accessor methods

  _get_edit_table_data: (els) ->
    _.compact _.map els, (el) =>
      key = $(el).data('attribute')
      value = @_get_input_data(el)
      unless key == 'Created' || key == 'Updated'
        {"#{key}": value}

  _get_input_data: (i) ->
    data = @_get_data_from_input(i)
    @_sanitize_data_input(data)

  _get_data_from_input: (i) ->
    $(i).value?() || $(i).val?()

  _sanitize_data_input: (data) ->
    if data == '✗'
      return 'true'
    else if data == '✓'
      return 'false'
    data
