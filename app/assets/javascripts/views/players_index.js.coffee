class App.Views.PlayersIndex extends Backbone.View
  template: ich.players_index

  render: ->
    models = @collection.models
    @$el.html @template
    this
