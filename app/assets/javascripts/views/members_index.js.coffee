class App.Views.MembersIndex extends Backbone.View
  template: ich.members_index

  relevant_attributes: ['name', 'nickname', 'wftda_id_number',
                        'signed_wftda_waiver', 'signed_wftda_confidentiality',
                        'signed_league_bylaws']

  attribute_names: ['Name', 'Nickname', 'WFTDA ID', 'Signed League Bylaws',
                    'Signed WFTDA Waiver', 'Signed WFTDA Confidentiality']

  render: ->
    members = @_get_members(@collection.models)
    @$el.html @template(attributes: @attribute_names, members: members)
    this

  _get_members: (models) ->
    active_members = @_get_active_members(models)
    active_member_hashes = @_get_member_hashes(active_members)
    active_member_arrays = @_get_filtered_member_arrays(active_member_hashes)
    pretty_active_member_arrays = @_prettify_member_arrays(active_member_arrays)
    @_hashify_arrays(pretty_active_member_arrays)

  _get_active_members: (members) ->
    _.filter members, (member) ->
      _.isNull member.attributes.year_left

  _get_member_hashes: (models) ->
    _.map models, (model) ->
      model.attributes

  _get_filtered_member_arrays: (members) ->
    _.map members, (member) =>
      _.map @relevant_attributes, (attribute) => member[attribute]

  _prettify_member_arrays: (arrays) ->
    _.map arrays, (array) =>
      _.map array, (value) =>
        @_clean_value(value)

  _hashify_arrays: (arrays) ->
    _.map arrays, (array) ->
      ('attrs': array)

  _clean_value: (value) ->
    switch value
      when true then '✓'
      when false then '✗'
      when null then ''
      else value
