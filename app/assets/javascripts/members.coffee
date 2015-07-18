ERROR_CELLS = ['signed_wftda_waiver', 'signed_wftda_confidentiality',
              'signed_league_bylaws', 'passed_wftda_test']
WARNING_CELLS = ['status', 'league_job', 'google_doc_access']

color_cells: ->
  _.each ERROR_CELLS , (name) ->
    console.log "td.#{name}"
    debugger
    _.each $("td.#{name}"), (cell) ->
      console.log $(cell).text()
      if $(cell).text() == 'false'
        $(cell).addClass('error')
