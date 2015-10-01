window.Membership =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    Backbone.history.start(pushState: true)

# Site wide alias for ease of typing
window.App = window.Membership

$(document).ready ->
  Membership.initialize()
