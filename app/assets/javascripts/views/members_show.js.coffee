class App.Views.MembersShow extends Backbone.View
  template: ich.members_show

  render: ->
    model = @_get_member(@model)
    @$el.html @template(model: model)
    this

  _get_member: (model) ->
    model.attributes
