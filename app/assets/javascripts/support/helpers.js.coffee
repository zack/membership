db.Helpers =

  header_map: (headers, omissions = []) ->
    headers = _.difference headers, omissions
    _.map headers, (header) =>
      @map_header(header)

  map_header: (header) ->
    switch header
      when 'id'                           then 'ID'
      when 'name'                         then 'Name'
      when 'nickname'                     then 'Nickname'
      when 'forum_handle'                 then 'Forum Handle'
      when 'address'                      then 'Address'
      when 'date_of_birth'                then 'Date Of Birth'
      when 'primary_insurance'            then 'Primary Insurance'
      when 'purchased_wftda_insurance'    then 'Purchased WFTDA Insurance'
      when 'passed_wftda_test'            then 'Passed WFTDA Test'
      when 'phone_number'                 then 'Phone Number'
      when 'wftda_id_number'              then 'WFTDA ID'
      when 'signed_league_bylaws'         then 'Signed League Bylaws'
      when 'signed_wftda_waiver'          then 'Signed WFTDA Waiver'
      when 'signed_wftda_confidentiality' then 'Signed WFTDA Confidentiality'
      when 'active'                       then 'Active'
      when 'google_doc_access'            then 'Google Doc Access'
      when 'year_joined'                  then 'Year Joined'
      when 'year_left'                    then 'Year Left'
      when 'reason_left'                  then 'Reason Left'
      when 'date_started'                 then 'Date Started'
      when 'date_ended'                   then 'Date Ended'
      when 'created_at'                   then 'Created At'
      when 'updated_at'                   then 'Updated At'
      else
        console.log 'Warning: Unmatched header at header map:', header
        header

  clean_table_value: (value) ->
    if typeof(value) == 'string'
      if value.match(/^\d{4}-\d{2}-\d{2}$/)
        new Date(value).toString().slice(4,15)
      else if value.match(/\d{10}/)
        value.replace(/^(\d{3})(\d{3})(\d{4})$/, '$1-$2-$3')
      else
        value
    else
      switch value
        when true then '✓'
        when false then '✗'
        when null then ''
        else value
