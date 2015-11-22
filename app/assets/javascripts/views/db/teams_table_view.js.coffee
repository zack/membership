class db.TeamsTableView extends Marionette.CompositeView
  template: ich.teams_table
  id: 'team_collection'
  class: 'teams_table'
  childViewContainer: 'tbody'
  templateHelpers: ->
    table_headers: @_get_table_headers

  TABLE_HEADERS: ['name']

  getChildView: ->
    db.TeamsTableRowView

  childViewOptions: ->
    table_headers: @TABLE_HEADERS

  _get_table_headers: =>
    _.map @TABLE_HEADERS, (h) =>
      db.Helpers.map_header(h)
