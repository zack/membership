class db.MemberIndexRowView extends Marionette.ItemView
  template: ich.member_index_row
  tagName: 'tr'
  className: 'member_index_row_view'
  templateHelpers: ->
    member_info: @_get_member_info

  initialize: (options) ->
    @table_headers = options.table_headers

  _get_member_info: =>
    info = {}
    _.each @table_headers, (h) =>
      value = db.Helpers.clean_table_value @model.get(h)
      info[h] = value
    info
