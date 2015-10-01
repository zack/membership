class App.Routers.TeamsRouter extends Backbone.Router
  routes:
    ''            : 'teams'
    'teams'     : 'teams'
    'teams/:id' : 'team'
    'teams/*'   : 'teams'

  'team': (id) ->
    view = new App.Views.TeamsShow(model: App.AllTeams.get(id))
    $('#container').html(view.render().el)

  'teams': ->
    attrs = ['id', 'players']
    table_omissions = ['id']

    view = new App.Views.TeamsIndex
      collection: App.AllTeams
      attrs: attrs
      table_omissions: table_omissions
    $('#container').html(view.render().el)
