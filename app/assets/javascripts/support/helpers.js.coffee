db.Helpers =

  header_map: (headers, omissions = []) ->
    headers = _.difference headers, omissions
    _.map headers, (header) =>
      @map_header(header)

  map_header: (header) ->
    switch header
      when 'active'                       then 'Active'
      when 'address'                      then 'Address'
      when 'created_at'                   then 'Created'
      when 'date_ended'                   then 'Date Ended'
      when 'date_of_birth'                then 'Date Of Birth'
      when 'date_started'                 then 'Date Started'
      when 'forum_handle'                 then 'Forum Handle'
      when 'google_doc_access'            then 'Google Doc Access'
      when 'id'                           then 'ID'
      when 'name'                         then 'Name'
      when 'nickname'                     then 'Nickname'
      when 'passed_wftda_test'            then 'Passed WFTDA Test'
      when 'phone_number'                 then 'Phone Number'
      when 'primary_insurance'            then 'Primary Insurance'
      when 'purchased_wftda_insurance'    then 'Purchased WFTDA Insurance'
      when 'reason_left'                  then 'Reason Left'
      when 'relationship'                 then 'Relationship'
      when 'signed_league_bylaws'         then 'Signed League Bylaws'
      when 'signed_wftda_confidentiality' then 'Signed WFTDA Confidentiality'
      when 'signed_wftda_waiver'          then 'Signed WFTDA Waiver'
      when 'updated_at'                   then 'Updated'
      when 'wftda_id_number'              then 'WFTDA ID'
      when 'year_joined'                  then 'Year Joined'
      when 'year_left'                    then 'Year Left'
      else
        header

  clean_table_value: (value) ->
    if typeof(value) == 'string'
      if value.match(/\d{10}/)
        value.replace(/^(\d{3})(\d{3})(\d{4})$/, '$1-$2-$3')
      else
        value
    else
      switch value
        when null then ''
        when true then '✓'
        when false then '✗'
        else value
