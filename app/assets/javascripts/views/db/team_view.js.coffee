class db.TeamView extends Marionette.ItemView
  template: ich.team
  className: 'team_view'
  templateHelpers: ->
    name: @_get_team_name
    players: @_get_players

  events:
    'click td.link': '_handle_tdlink_click'

  initialize: ->
    @players = db.players.where({team_id: @model.id})

  _get_players: =>
    current = []
    previous = []

    _.each @players, (player) =>
      p = @_build_player(player)
      if player.get('date_ended')?
        previous.push p
      else
        current.push p

    [
      current: _.sortBy(current, (p) -> p.name),
      previous: _.sortBy(previous, (p) -> p.name)
    ]

  _build_player: (player) ->
    {
      name: player.get('name'),
      number: player.get('number'),
      member_name: db.members.get(player.get('member_id')).get('street_name'),
      member_id: player.get('member_id'),
      started: player.get('date_started'),
      ended: player.get('date_ended'),
      active: db.Helpers.clean_table_value(player.get('active'))
    }

  _get_team_name: =>
    @model.get('name')

  _handle_tdlink_click: (e) ->
    id = $(e.currentTarget).data('id')
    db.app.Router.navigate("members/#{id}", {trigger: true})
