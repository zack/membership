class db.MembershipRouter extends Marionette.AppRouter

  routes:
    ''               : 'members'

    'members/create' : 'create_member'
    'members(/)'     : 'members'
    'members/:id'    : 'member'

    'active'         : 'active'
    'officials'      : 'officials'
    'volunteers'     : 'volunteers'

    'teams'          : 'teams'
    'teams/:id'      : 'team'

  members: ->
    db.app.app_region.show(
      new db.MemberIndexView
        collection: db.members)

  member: (id) ->
    db.app.app_region.show(
      new db.MemberView
        model: db.members.get(id))

  active: ->
    db.app.app_region.show(
      new db.MemberIndexView
        collection: new db.MembersCollection(
          db.members.where({active: true})))

  officials: ->
    db.app.app_region.show(
      new db.MemberIndexView
        collection: new db.MembersCollection(
          db.members.where({official: true})))

  volunteers: ->
    db.app.app_region.show(
      new db.MemberIndexView
        collection: new db.MembersCollection(
          db.members.where({volunteer: true})))

  create_member: (id) ->
    db.app.app_region.show(
      new db.MemberCreateView)

  teams: ->
    db.app.app_region.show(
      new db.TeamIndexView
        collection: db.teams)

  team: (id) ->
    db.app.app_region.show(
      new db.TeamView
        model: db.teams.get(id))
