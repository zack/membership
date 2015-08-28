class App.Routers.MembershipRouter extends Backbone.Router
  routes:
    ''            : 'index'
    'members'    : 'members'
    'members/:id' : 'member'

  'index': ->
    console.log 'Requested index'

  'member': (id) ->
    console.log "Requested member with id #{id}"

  'members': ->
    console.log 'Requested members index'
    view = new App.Views.MembersIndex()
    $('#container').html(view.render().el)
