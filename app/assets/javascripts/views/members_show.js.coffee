class App.Views.MembersShow extends Backbone.View
  template: ich.members_show

  omitted_keys: ['id', 'created_at', 'updated_at']

  render: ->
    member = @_get_member(@model)
    pretty_member = @_prettify_member(member)
    @$el.html @template
      member: @_generate_hash(pretty_member)
    this

  _get_member: (model) ->
    _.omit model.attributes, (value, key) =>
      _.contains @omitted_keys, key

  _generate_hash: (model) ->
    _.map model, (value, key) ->
      {key: key, value: value}

  _prettify_member: (member) ->
    _.object(
      _.map member, (value, key) =>
        [App.Helpers.map_header(key), App.Helpers.clean_table_value(value)]
    )
