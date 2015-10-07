class App.Views.MembersIndex extends Backbone.View
  template: ich.members_index

  headers: ['id', 'name', 'nickname', 'wftda_id_number', 'signed_league_bylaws',
            'signed_wftda_waiver', 'signed_wftda_confidentiality']

  table_omissions: ['id']

  render: ->
    @$el.html @template
      headers: @_get_headers(@headers)
      members: @_get_members(@collection.models)
    this

  _get_headers: (headers)->
    App.Helpers.header_map headers, @table_omissions

  _get_members: (models)->
    active_member_hashes = @_get_member_hashes(models)
    filtered_active_member_hashes = @_filter_member_hashes(active_member_hashes)
    pretty_member_hashes = @_prettify_member_hashes(filtered_active_member_hashes)
    @_break_out_member_names(pretty_member_hashes)

  # Just return the attributes from each model
  _get_member_hashes: (models) ->
    _.map models, (model) ->
      model.attributes

  # Remove unneeded attributes from each member
  _filter_member_hashes: (members) ->
    _.map members, (member) =>
      _.omit member, (value, key) =>
        !_.contains @headers, key

  # Run member attr values through the pretty-making helper
  # Turns things like 'true' into checkmarks, parses dates, phones, etc.
  _prettify_member_hashes: (members) ->
    _.map members, (member) =>
      _.object (
        _.map member, (value, key) =>
          [key, App.Helpers.clean_table_value(value)]
      )

  # This is for the templating so we can turn names into links to show views
  _break_out_member_names: (members) ->
    _.map members, (member) =>
      name: member.name
      id: member.id
      rest: _.values @_remove_name_and_id(member)

  # Helper for the above method
  _remove_name_and_id: (member) ->
    _.omit member, (value, key) ->
      _.contains ['id', 'name'], key
