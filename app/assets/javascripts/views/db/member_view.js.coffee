class db.MemberView extends Marionette.ItemView
  template: ich.member
  id: 'member_view'
  templateHelpers: ->
    member_info: @_get_member_info
    name: @_get_member_name

  IGNORED_HEADERS: ['name', 'id']

  initialize: (options) ->
    @model = options.model

  _get_member_info: =>
    _.compact _.map @model.attributes, (v, k) =>
      unless _.contains @IGNORED_HEADERS, k
        attribute = db.Helpers.map_header k
        value = db.Helpers.clean_table_value v
        {attribute: attribute,value: value}

  _get_member_name: =>
    @model.get('name')
