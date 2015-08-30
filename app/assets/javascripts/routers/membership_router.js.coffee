class App.Routers.MembershipRouter extends Backbone.Router
  routes:
    'members'     : 'members'
    'members/:id' : 'member'
    'members/*'   : 'members'

  'member': (id) ->
    view = new App.Views.MembersShow(model: App.AllMembers.get(id))
    $('#container').html(view.render().el)

  'members': ->
    attrs = ['id', 'name', 'nickname', 'wftda_id_number',
             'signed_league_bylaws', 'signed_wftda_waiver',
             'signed_wftda_confidentiality']
    table_omissions = ['id']

    view = new App.Views.MembersIndex
      collection: App.AllMembers
      attrs: attrs
      table_omissions: table_omissions
    $('#container').html(view.render().el)
