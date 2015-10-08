$ ->
  Backbone.appendDataTypeToUrl = false
  db.app = new Marionette.Application()
  db.app.addInitializer ->
    db.app.Router = new db.MembershipRouter()

  db.app.on 'start', ->
    Backbone.history.start({pushState: true})

  db.app.addRegions(
    app_region: '#db'
  )

  db.app.start()
