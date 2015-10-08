class db.MembershipRouter extends Marionette.AppRouter

  routes:
    ''            : 'members'

    'members'     : 'members'
    'members/:id' : 'member'
    'members/*'   : 'members'

    'players'     : 'players'
    'players/:id' : 'player'
    'players/*'   : 'players'

    'teams'       : 'teams'
    'teams/:id'   : 'team'
    'teams/*'     : 'teams'

    '*route'      : 'default'

  members: ->
    db.app.app_region.show(
      new db.MemberCollectionView
        collection: db.members)

  default: ->
    console.log 'membership_router default route'
