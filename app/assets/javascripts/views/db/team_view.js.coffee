class db.TeamView extends Marionette.ItemView
  template: ich.team
  className: 'team_view'
  templateHelpers: ->
    name: @_get_team_name
    players: @_get_players

  events:
    'click td.link' : '_handle_tdlink_click'
    'click .number' : '_resort_number'
    'click .name'   : '_resort_name'

  initialize: ->
    @players = new db.PlayersCollection(db.players.where({team_id: @model.id}))

  _get_players: =>
    current = []
    previous = []

    _.each @players.models, (player) =>
      p = @_build_player(player)
      if player.get('date_ended')?
        previous.push p
      else
        current.push p

    [current: current, previous: previous]

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

  _resort_name: (e) =>
    e.stopPropagation()
    classes = $('.name:first').attr('class')
    if classes.indexOf('asc') > -1 && classes.indexOf('sorting') > -1
      reverse = true
      @players.use_name_comparator(true)
    else
      @players.use_name_comparator(false)
    @players.sort()
    @render()
    if reverse
      $('.name').removeClass('asc').addClass('desc')
    else
      $('.name').removeClass('desc').addClass('asc')
    $('.name').addClass('sorting')

  _resort_number: (e) =>
    e.stopPropagation()
    classes = $('.number:first').attr('class')
    if classes.indexOf('asc') > -1 && classes.indexOf('sorting') > -1
      reverse = true
      @players.use_number_comparator(true)
    else
      @players.use_number_comparator(false)
    @players.sort()
    @render()
    if reverse
      $('.number').removeClass('asc').addClass('desc')
    else
      $('.number').removeClass('desc').addClass('asc')
    $('.number').addClass('sorting')
    $('.name').removeClass('sorting')

  _handle_tdlink_click: (e) ->
    id = $(e.currentTarget).data('id')
    db.app.Router.navigate("members/#{id}", {trigger: true})
