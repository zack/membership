App.Helpers =

  header_map: (headers, omissions) ->
    headers = _.difference headers, omissions
    _.map headers, (header) ->
      switch header
        when 'id'                           then 'ID'
        when 'name'                         then 'Name'
        when 'nickname'                     then 'Nickname'
        when 'wftda_id_number'              then 'WFTDA ID'
        when 'signed_league_bylaws'         then 'Signed League Bylaws'
        when 'signed_wftda_waiver'          then 'Signed WFTDA Waiver'
        when 'signed_wftda_confidentiality' then 'Signed WFTDA Confidentiality'
        when 'date_started'                 then 'Date Started'
        when 'date_ended'                   then 'Date Ended'
        else
          console.log 'Warning: Unmatched header at header map:', header
          header

  clean_table_value: (value) ->
    switch value
      when true then '✓'
      when false then '✗'
      when null then ''
      else value

