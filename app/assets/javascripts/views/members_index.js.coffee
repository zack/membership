class App.Views.MembersIndex extends Backbone.View
  template: ich.members_index

  render: ->
    @$el.html @template(members: @collection)
    this
