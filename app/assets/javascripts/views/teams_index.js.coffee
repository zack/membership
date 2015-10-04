class App.Views.TeamsIndex extends Backbone.View
  template: ich.teams_index

  EMPTY_CELL: '<td></td>'

  render: ->
    models = @collection.models
    @$el.html @template
      teams: @_get_teams(models)
      body_rows: @_build_body_rows(models)
    this

  _get_teams: (models) ->
    _.map models, (model) =>
      id: model.attributes.id
      name: model.attributes.name
      url: @_get_team_url(model.attributes.id)

  _get_team_url: (id) ->
    "/teams/#{id}"

  _build_body_rows: (models) ->
    team_arrays = @_build_team_arrays(@_build_rosters(models))
    table_length = _.max _.map team_arrays, (team) -> team.length

    rows = []

    for i in [0...table_length]
      rows.push []

      _.each team_arrays, (team) =>
        if team[i]?
          rows[i].push @_build_cell team[i]
        else
          rows[i].push @EMPTY_CELL
    rows

  _build_rosters: (models) ->
    _.map models, (model) ->
      model.attributes.players

  _build_team_arrays: (teams) ->
    _.map teams, (team) =>
      @_build_team_array(team)

  _build_team_array: (team) ->
    _.map team, (player) ->
      id: player.id
      name: player.name

  _build_cell: (player) ->
    "<td><a href=/players/#{player.id}> #{player.name} </a></td>"
