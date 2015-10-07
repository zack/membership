class App.Routers.MembersRouter extends Backbone.Router
  routes:
    ''            : 'members'
    'members'     : 'members'
    'members/:id' : 'member'
    'members/*'   : 'members'

  'member': (id) ->
    view = new App.Views.MembersShow(model: App.AllMembers.get(id))
    $('#container').html(view.render().el)

  'members': ->
    view = new App.Views.MembersIndex
      collection: App.AllMembers
    $('#container').html(view.render().el)
