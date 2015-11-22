class db.TeamView extends Marionette.ItemView
  template: ich.team
  id: 'team_view'
  tagName: 'table'
  templateHelpers: ->
    team_info: @_get_team_info
    team_name: @_get_team_name

  IGNORED_HEADERS: ['id']

  initialize: (options) ->
    @model = options.model

  _get_team_info: =>
    _.compact _.map @model.attributes, (v, k) =>
      unless _.contains @IGNORED_HEADERS, k
        attribute = db.Helpers.map_header k
        value = db.Helpers.clean_table_value v
        {attribute: attribute,value: value}

  _get_team_name: =>
    @model.get('name')
