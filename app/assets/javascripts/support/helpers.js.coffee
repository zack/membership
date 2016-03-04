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
      when 'name'                         then 'Name'
      when 'id'                           then 'ID'
      when 'nickname'                     then 'Nickname'
      when 'street_name'                  then 'Street Name'
      when 'government_name'              then 'Government Name'
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
      if value.match(/^\d{10}$/)
        return value.replace(/^(\d{3})(\d{3})(\d{4})$/, '($1) $2-$3')
      if value.match(/^\d{4}-\d{2}-\d{2}T.*Z/)
        new Date(value).toString().slice(4,15)
      else
        value
    else
      switch value
        when null then ''
        when true then '✓'
        when false then '✗'
        else value

  header_index: (header) ->
    [
      'id',
      'nickname',
      'government_name',
      'street_name',
      'forum_handle',
      'phone_number',
      'address',
      'date_of_birth',
      'wftda_id_number',
      'primary_insurance',
      'purchased_wftda_insurance',
      'signed_wftda_waiver',
      'signed_wftda_confidentiality',
      'passed_wftda_test',
      'signed_league_bylaws',
      'google_doc_access',
      'active',
      'date_ended',
      'date_started',
      'year_joined',
      'year_left'
      'reason_left',
      'relationship',
      'updated_at',
      'created_at'
    ].indexOf(header)

  attributes_comparator: (a, b) =>
    header_index = db.Helpers.header_index

    a_key = a[0]
    b_key = b[0]

    if header_index(a_key) < header_index(b_key)
      return -1
    else if header_index(a_key) > header_index(b_key)
      return 1
    else
      return 0

