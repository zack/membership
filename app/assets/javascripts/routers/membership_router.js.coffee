class App.Routers.MembershipRouter extends Backbone.Router
  routes:
    ''            : 'members'
    'members'     : 'members'
    'members/:id' : 'member'

  'member': (id) ->
    console.log "requested member with id #{id}"
    view = new App.Views.MembersShow(model: App.AllMembers.get(id))
    $('#container').html(view.render().el)

  'members': ->
    console.log 'requested members'

    headers = ['name', 'nickname', 'wftda_id_number',
               'signed_league_bylaws', 'signed_wftda_waiver',
               'signed_wftda_confidentiality', 'id']
    table_omissions = ['id']

    view = new App.Views.MembersIndex
      collection: App.AllMembers
      headers: headers
      table_omissions: table_omissions
    $('#container').html(view.render().el)
