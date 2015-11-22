class db.MemberIndexView extends Marionette.CompositeView
  template: ich.member_index
  id: 'member_collection'
  class: 'member_index'
  childViewContainer: 'tbody'
  templateHelpers: ->
    table_headers: @_get_table_headers

  TABLE_HEADERS: ['name', 'nickname', 'wftda_id_number', 'signed_league_bylaws',
                 'signed_wftda_waiver', 'signed_wftda_confidentiality']

  getChildView: ->
    db.MemberIndexRowView

  childViewOptions: ->
    table_headers: @TABLE_HEADERS

  _get_table_headers: =>
    _.map @TABLE_HEADERS, (h) =>
      db.Helpers.map_header(h)
