class App.Views.TeamsShow extends Backbone.View
  template: ich.teams_show

  render: ->
    @$el.html @template
      team_name: @model.attributes.name
      players: @_generate_player_hashes(@model.attributes.players)
    this

  _generate_player_hashes: (players) ->
    _.map players, (player) ->
      player_id: player.id,
      player_name: player.name,
      player_number: player.number,
      date_started: player.date_started,
      member_id: player.member_id,
      member_name: player.member.name
