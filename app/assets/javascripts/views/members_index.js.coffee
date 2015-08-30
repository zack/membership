class App.Views.MembersIndex extends Backbone.View
  template: ich.members_index

  events:
    'click a': '_show_member'

  initialize: (options) ->
    @headers = options.headers
    @table_omissions = options.table_omissions

  render: ->
    @$el.html @template
      members: @_get_members()
      headers: @_get_headers()
    this

  _get_members: ->
    models = @collection.models
    active_member_hashes = @_get_member_hashes(models)
    filtered_active_member_hashes = @_filter_member_hashes(active_member_hashes)
    pretty_member_hashes = @_prettify_member_hashes(filtered_active_member_hashes)
    @_break_out_member_names(pretty_member_hashes)

  _get_headers: ->
    App.Helpers.header_map @headers, @table_omissions

  _get_active_members: (members) ->
    _.filter members, (member) ->
      _.isNull member.attributes.year_left

  _get_member_hashes: (models) ->
    _.map models, (model) ->
      model.attributes

  _filter_member_hashes: (members) ->
    _.map members, (member) =>
      _.omit member, (value, key) =>
        !_.contains @headers, key

  _prettify_member_hashes: (members) ->
    _.map members, (member) =>
      _.object (
        _.map member, (value, key) =>
          [key, App.Helpers.clean_table_value(value)]
      )

  _break_out_member_names: (members) ->
    _.map members, (member) =>
      name: member.name
      id: member.id
      rest: _.map @_remove_name_and_id(member), (value) -> value


  _remove_name_and_id: (member) ->
    _.omit member, (value, key) ->
      _.contains ['id', 'name'], key

  _show_member: (e) ->
    url = $(e.currentTarget).attr('href')
    Backbone.history.navigate(url, trigger: true)
    false
