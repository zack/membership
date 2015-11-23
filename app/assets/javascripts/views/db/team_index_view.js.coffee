class db.TeamIndexView extends Marionette.CompositeView
  template: ich.team_index
  id: 'team_index'
  class: 'team_index'
  childViewContainer: 'tbody'
  templateHelpers: ->
    table_headers: @_get_table_headers

  getChildView: ->
    db.TeamIndexRowView

  childViewOptions: ->
    table_headers: @TABLE_HEADERS

  _get_table_headers: =>
    _.map @TABLE_HEADERS, (h) =>
      db.Helpers.map_header(h)
