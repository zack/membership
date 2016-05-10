db.TableValidator =

  table_is_valid: (data_els)->
    results = _.map data_els, (el) =>
      switch $(el).data('attribute')
        when "nickname"
          @_nickname_is_valid(el)
        when "phone_number"
          @_phone_number_is_valid(el)
        when "number"
          @_wftda_number_is_valid(el)
        when "date_of_birth"
          @_date_is_valid(el)
        when "date_started"
          @_date_is_valid(el)
        when "date_ended"
          @_date_is_valid(el)
        when "wftda_id_number"
          @_wftda_id_is_valid(el)
        when "signed_wftda_waiver"
          @_bool_is_valid(el)
        when "signed_wftda_confidentiality"
          @_bool_is_valid(el)
        when "signed_leauge_bylaws"
          @_bool_is_valid(el)
        when "purchased_wftda_insurance"
          @_bool_is_valid(el)
        when "passed_wftda_test"
          @_bool_is_valid(el)
        when "active"
          @_bool_is_valid(el)
        when "google_doc_access"
          @_bool_is_valid(el)
        when "year_joined"
          @_year_is_valid(el)
        when "year_left"
          @_year_is_valid(el)

    !_.contains results, false

  _nickname_is_valid: (input) ->
    value = input.value
    if !value.length > 0
      @_set_el_to_error(input)
      return false

  _phone_number_is_valid: (input) ->
    value = input.value.replace(/\D/g,'')
    if !value.match(/^\d{10}$/) and !!value
      @_set_el_to_error(input)
      return false

  _date_is_valid: (input) ->
    value = input.value
    if !value.match(/^\d{4}-\d{2}-\d{2}$/) and !!value
      @_set_el_to_error(input)
      return false

  _bool_is_valid: (input) ->
    value = input.value
    if !_.contains(['true','false', 'null'], value) and !!value
      @_set_el_to_error(input)
      return false

  _wftda_id_is_valid: (input) ->
    value = input.value
    if !value.match(/^\d{5,6}$/) and !!value
      @_set_el_to_error(input)
      return false

  _wftda_number_is_valid: (input) ->
    value = input.value
    if !value.match(/^\d{1,4}$/) and !!value
      @_set_el_to_error(input)
      return false

  _year_is_valid: (input) ->
    value = input.value
    if !value.match(/^\d{4}$/) and !!value
      @_set_el_to_error(input)
      return false

  _set_el_to_error: (el) ->
    $(el).addClass('error')
