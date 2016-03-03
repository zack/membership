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
  BOOLEAN_EDIT_BOXES: ['signed_wftda_waiver', 'signed_wftda_confidentiality',
  'signed_league_bylaws', 'purchased_wftda_insurance', 'passed_wftda_test',
  'active', 'google_doc_access']

  events: ->
    'click button.edit':                '_show_edit_table'
    'click button.save:not(.disabled)': '_handle_save'
    'click button.cancel':              '_handle_cancel'
    'change input':                     '_handle_input_change' # datepicker
    'input input':                      '_handle_input_change'
    'change select':                    '_handle_select_change'
    'focus td input':                   '_handle_td_input_focus'
    'focus td select':                  '_handle_td_input_focus'
    'blur td input':                    '_handle_td_input_blur'
    'blur td select':                   '_handle_td_input_blur'

  onShow: =>
    @_prepare_edit_tables()

  _prepare_edit_tables: ->
    @_limit_input_length()
    @_transform_boolean_inputs()
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
    $(view).find('.text-primary').removeClass('text-primary')
    $(view).find('.edit-table-buttons').show()
    $(view).find('.edit-table-buttons > .save').addClass('disabled')

  _reset_edit_table: (e) ->
    table = $(e.currentTarget).parents('.view').find('table.edit')
    _.each @model.attributes, (val, attr) =>
      if _.contains @BOOLEAN_EDIT_BOXES, attr
        $(table).find("select[data-attribute='#{attr}']").val("#{val}")
      else
        $(table).find("input[data-attribute='#{attr}']").html(val)

  _update_view_table: (e) ->
    table = $(e.currentTarget).parents('.view').find('table.show')
    _.each @model.attributes, (val, attr) =>
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
    $(e.currentTarget).parent('.input').removeClass('has-danger')
    $(e.currentTarget).parents('.view').find('button.save').removeClass('disabled')

  _handle_td_input_focus: (e) ->
    tr = $(e.currentTarget).parents('tr')
    tr.addClass('focus')

  _handle_td_input_blur: (e) ->
    tr = $(e.currentTarget).parents('tr')
    tr.removeClass('focus')

  _handle_save: (e) =>
    table = $(e.currentTarget).parents('.view').find('table.edit')
    data_els = $(table).find('td.input').children()
    if db.TableValidator.table_is_valid(data_els)
      data = @_get_edit_table_data(data_els)
      @_submit(e, data)

  _submit: (e, data) ->
    new db.Member().save data,
      success: (model) => @_handle_submit_success(e, model)

  _handle_cancel: (e) =>
    table = $(e.currentTarget).parents('.view').find('table.edit')
    @_show_view_table(e)
    @_reset_edit_table(e)

  _handle_submit_success: (e, model) =>
    @model = model
    @_show_view_table(e)
    @_update_view_table(e)

  # Data cleaning methods

  _build_member_info: =>
    _.compact _.map @model.attributes, (v, k) =>
      unless _.contains @IGNORED_MEMBER_HEADERS, k
        attribute = db.Helpers.map_header k
        model_attribute = k
        value = db.Helpers.clean_table_value v
        {attribute: attribute, value: value, model_attribute: model_attribute}

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
      value = $("td[data-attribute='#{attr}']").text()
      $("[data-attribute='#{attr}']").parent('td').html(
        "<select data-attribute='#{attr}'>
        <option value=''></option>
        <option value='true'>✓</option>
        <option value='false'>✗</option>
        </select>")

      $("[data-attribute='#{attr}']").val(@_symbol_to_bool(value))

  _generate_datepickers: ->
    $("[data-attribute='date_of_birth']").datepicker({
        format: 'yyyy-mm-dd',
        orientation: 'bottom left',
        startDate: '-100y',
        endDate: '-18y',
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
    $('[data-attribute="created_at"]').prop('disabled', true)
    $('[data-attribute="updated_at"]').prop('disabled', true)

  # Table data accessor methods

  _get_edit_table_data: (els) ->
    @attrs = id: @model.get('id')
    _.each els, (el) =>
      key = $(el).data('attribute')
      value = @_get_input_data(el)
      unless key == 'Created' || key == 'Updated'
        @attrs[key] = value
    return @attrs

  _get_input_data: (i) ->
    @_get_data_from_input(i)

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
