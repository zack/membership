class db.MembershipRouter extends Marionette.AppRouter

  routes:
    ''            : 'members'

    'members(/)'  : 'members'
    'members/:id' : 'member'

    'teams'       : 'teams'
    'teams/:id'   : 'team'

  members: ->
    db.app.app_region.show(
      new db.MemberIndexView
        collection: db.members)

  member: (id) ->
    db.app.app_region.show(
      new db.MemberView
        model: db.members.get(id))

  teams: ->
    db.app.app_region.show(
      new db.TeamIndexView
        collection: db.teams)

  team: (id) ->
    db.app.app_region.show(
      new db.TeamView
        model: db.teams.get(id))
