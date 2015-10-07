class App.Routers.TeamsRouter extends Backbone.Router
  routes:
    ''          : 'teams'
    'teams'     : 'teams'
    'teams/:id' : 'team'
    'teams/*'   : 'teams'

  'team': (id) ->
    view = new App.Views.TeamsShow(model: App.AllTeams.get(id))
    $('#container').html(view.render().el)

  'teams': ->

    view = new App.Views.TeamsIndex
      collection: App.AllTeams
    $('#container').html(view.render().el)
