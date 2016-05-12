$ ->
  Backbone.appendDataTypeToUrl = false
  db.app = new Marionette.Application()
  db.app.addInitializer ->
    db.app.Router = new db.MembershipRouter()
    db.app.Router.on('route', -> $(document).scrollTop(0)) # not perfect

  db.app.on 'start', ->
    Backbone.history.start({pushState: true})
    $(document).on 'click', 'a:not([data-bypass])', (e) ->
      href = $(this).attr('href')
      protocol = @protocol

      if href.slice(protocol.length) != protocol
        $(document).scrollTop(0)
        e.preventDefault()
        db.app.Router.navigate(href, true)

  db.app.addRegions(
    app_region: '.db .content'
  )

  db.app.start()
