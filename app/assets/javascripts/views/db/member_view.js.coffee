class db.MemberView extends Marionette.ItemView
  template: ich.member
  id: 'member_view'
  templateHelpers: ->
    member_info: @_get_member_info

  initialize: (options) ->
    @model = options.model

  _get_member_info: =>
    _.map @model.attributes, (v, k) ->
      header = db.Helpers.map_header k
      {attribute: header,value: v}
