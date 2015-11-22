class db.MembersTableView extends Marionette.CompositeView
  template: ich.members_table
  tagName: 'table'
  id: 'member_collection'
  class: 'members_table'
  templateHelpers: ->
    table_headers: @_get_table_headers

  TABLE_HEADERS: ['name', 'nickname', 'wftda_id_number', 'signed_league_bylaws',
                 'signed_wftda_waiver', 'signed_wftda_confidentiality']

  getChildView: ->
    db.MembersTableRowView

  childViewOptions: ->
    table_headers: @TABLE_HEADERS

  _get_table_headers: =>
    _.map @TABLE_HEADERS, (h) =>
      db.Helpers.map_header(h)
