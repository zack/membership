class db.MemberView extends Marionette.CompositeView
  template: ich.member
  id: 'member_view'
  templateHelpers: ->
    member_info: @_get_member_info
    name: @_get_member_name
    has_emergency_contacts: @_has_emergency_contacts
    emergency_contacts: @_get_emergency_contacts
    has_skater_profiles: @_has_skater_profiles
    skater_profiles: @_get_skater_profiles

  IGNORED_MEMBER_HEADERS: ['name', 'id', 'emergency_contacts', 'players']
  IGNORED_EMERGENCY_CONTACT_HEADERS: ['id', 'member_id']
  SKATER_PROFILE_HEADERS: ['name', 'number', 'date_started', 'date_ended', 'active']
  BOOLEAN_EDIT_BOXES: ['Signed WFTDA Waiver', 'Signed WFTDA Confidentiality',
  'Signed League Bylaws', 'Purchased WFTDA Insurance', 'Passed WFTDA Test',
  'Active', 'Google Doc Access']

  events: ->
    'click h3.edit': '_show_edit_table'
    'click h3.save': '_handle_save'

  onShow: =>
    @_prepare_edit_tables()

  _get_member_info: =>
    _.compact _.map @model.attributes, (v, k) =>
      unless _.contains @IGNORED_MEMBER_HEADERS, k
        attribute = db.Helpers.map_header k
        value = db.Helpers.clean_table_value v
        {attribute: attribute, value: value}

  _get_member_name: =>
    @model.get('name')

  _has_emergency_contacts: =>
    @model.get('emergency_contacts').length > 0

  _get_emergency_contacts: =>
    _.map @model.get('emergency_contacts'), (e) =>
      {contact_info:
        _.compact _.map e, (v, k) =>
          unless _.contains @IGNORED_EMERGENCY_CONTACT_HEADERS, k
            attribute = db.Helpers.map_header k
            value = db.Helpers.clean_table_value v
            {attribute: attribute,value: value}}

  _has_skater_profiles: =>
    @model.get('players').length > 0

  _get_skater_profiles: =>
    _.flatten _.map @model.get('players'), (p) =>
      if p.teams.length > 0
        _.map p.teams, (t) =>
          @_build_profile_row(p, t)
      else
        @_build_profile_row(p, [name: null])

  _build_profile_row: (player, team) ->
    row = {team_name: team.name, team_id: team.id}
    _.each @SKATER_PROFILE_HEADERS, (h) =>
      value = db.Helpers.clean_table_value player[h]
      row[h] = value
    row

  _prepare_edit_tables: ->
    @_limit_input_length()
    @_disable_timestamps()
    @_transform_boolean_inputs()

  _limit_input_length: ->
    # Every input field except those below have MySQL max text lengths of 255
    # Some input fields (e.g. year joined) may have even stricter validations
    $('input').attr('maxlength', 255)

    # These are text columns and MySQL can take up to 65535 chars
    $('input[data-attribute="Reason Left"]').attr('maxlength', 65535)
    $('input[data-attribute="Address"]').attr('maxlength', 65535)

  _transform_boolean_inputs: ->
    _.each @BOOLEAN_EDIT_BOXES, (attr) =>
      value = $("[data-attribute='#{attr}']").val()
      $("[data-attribute='#{attr}']").parent('td').html(
        "<select data-attribute='#{attr}'>
        <option value=''></option>
        <option value='✓'>✓</option>
        <option value='✗'>✗</option>
        </select>")
      $("[data-attribute='#{attr}']").val(value)

  _disable_timestamps: ->
    $('[data-attribute="Created"]').prop('disabled', true)
    $('[data-attribute="Updated"]').prop('disabled', true)

  _handle_save: (e) ->
    table = $(e.currentTarget).parents('.view').find('table.edit')
    data_els = $(table).find('td.input').children()
    if @_table_is_valid(data_els)
      data = @_get_edit_table_data(data_els)
      # TODO persist data
      @_show_view_table(e)

  _table_is_valid: (els)->
    _.each els, (el) ->
      valid = switch $(el).data('attribute')
        when "Phone Number"
          @_phone_number_is_valid(el.value)
        when "Date of Birth"
          @_dob_is_valid(el.value)
        when "WFTDA ID"
          @_bool_is_valid(el.value)
        when "Signed WFTDA Waiver"
          @_bool_is_valid(el.value)
        when "Signed WFTDA Confidentiality"
          @_bool_is_valid(el.value)
        when "Signed League Bylaws"
          @_bool_is_valid(el.value)
        when "Purchased WFTDA Insurance"
          @_bool_is_valid(el.value)
        when "Passed WFTDA Test"
          @_bool_is_valid(el.value)
        when "Active"
          @_bool_is_valid(el.value)
        when "Google Doc Access"
          @_bool_is_valid(el.value)
        when "Year Joined"
          @_year_is_valid(el.value)
        when "Year Left"
          @_year_is_valid(el.value)
      if !valid
      else
        true

  _phone_number_is_valid: (input) ->
    input.replace(/\D/g,'').length == 10

  _dob_is_valid: (input) ->
  _bool_is_valid: (input) ->
  _year_is_valid: (input) ->

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
