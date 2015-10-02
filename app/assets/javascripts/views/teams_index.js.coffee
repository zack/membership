class App.Views.TeamsIndex extends Backbone.View
  template: ich.teams_index

  render: ->
    @$el.html @template
      teams: @_get_teams(@collection.models)
    this

  _get_teams: (models) ->
    _.map models, (model) ->
      id: model.attributes.id
      name: model.attributes.name
