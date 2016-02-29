db.TableValidator =

  table_is_valid: (data_els)->
    results = _.map data_els, (el) =>
      switch $(el).data('attribute')
        when "Phone Number"
          @_phone_number_is_valid(el)
        when "Date Of Birth"
          @_dob_is_valid(el)
        when "WFTDA ID"
          @_wftda_id_is_valid(el)
        when "Signed WFTDA Waiver"
          @_bool_is_valid(el)
        when "Signed WFTDA Confidentiality"
          @_bool_is_valid(el)
        when "Signed League Bylaws"
          @_bool_is_valid(el)
        when "Purchased WFTDA Insurance"
          @_bool_is_valid(el)
        when "Passed WFTDA Test"
          @_bool_is_valid(el)
        when "Active"
          @_bool_is_valid(el)
        when "Google Doc Access"
          @_bool_is_valid(el)
        when "Year Joined"
          @_year_is_valid(el)
        when "Year Left"
          @_year_is_valid(el)

    !_.contains results, false

  _phone_number_is_valid: (input) ->
    value = input.value.replace(/\D/g,'')
    if !value.match(/^\d{10}$/) and !!value
      @_set_el_to_error(input)
      return false

  _dob_is_valid: (input) ->
    value = input.value
    if !value.match(/^\d{4}-\d{2}-\d{2}$/) and !!value
      @_set_el_to_error(input)
      return false

  _bool_is_valid: (input) ->
    value = input.value
    if !_.contains(['✓','✗'], value) and !!value
      @_set_el_to_error(input)
      return false

  _wftda_id_is_valid: (input) ->
    value = input.value
    if !value.match(/^\d{5}$/) and !!value
      @_set_el_to_error(input)
      return false

  _year_is_valid: (input) ->
    value = input.value
    if !value.match(/^\d{4}$/) and !!value
      @_set_el_to_error(input)
      return false

  _set_el_to_error: (el) ->
    $(el).parent().addClass('has-danger')
