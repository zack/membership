class App.Views.TeamsIndex extends Backbone.View
  template: ich.teams_index

  render: ->
    @$el.html @template
    this
