class App.Routers.PlayersRouter extends Backbone.Router
  routes:
    ''            : 'players'
    'players'     : 'players'
    'players/:id' : 'player'
    'players/*'   : 'players'

  'player': (id) ->
    console.log 'PlayersRouter#players'

  'players': ->
    console.log 'PlayersRouter#players'
