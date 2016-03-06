class db.TeamView extends Marionette.ItemView
  template: ich.team
  id: 'team_view'
  templateHelpers: ->
    name: @_get_team_name
    players: @_get_players

  events:
    'click td.link': '_handle_tdlink_click'

  _get_players: =>
    current = []
    previous = []

    _.each @model.get('players'), (player) =>
      p = @_build_player(player)
      if player.date_ended?
        previous.push p
      else
        current.push p

    [
      current: _.sortBy(current, (p) -> p.name),
      previous: _.sortBy(previous, (p) -> p.name)
    ]

  _build_player: (player) ->
    {
      name: player.name,
      number: player.number,
      member_name: player.member.street_name,
      member_id: player.member_id,
      started: player.date_started,
      ended: player.date_ended,
      active: db.Helpers.clean_table_value(player.active)
    }

  _get_team_name: =>
    @model.get('name')

  _handle_tdlink_click: (e) ->
    id = $(e.currentTarget).data('id')
    db.app.Router.navigate("members/#{id}", {trigger: true})
