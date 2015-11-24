class db.MemberView extends Marionette.ItemView
  template: ich.member
  id: 'member_view'
  templateHelpers: ->
    member_info: @_get_member_info
    name: @_get_member_name
    has_emergency_contacts: @_has_emergency_contacts
    emergency_contacts: @_get_emergency_contacts
    has_teams: @_has_teams
    teams: @_get_teams

  IGNORED_HEADERS: ['name', 'id', 'emergency_contacts', 'players']
  IGNORED_EC_HEADERS: ['id', 'member_id']

  TEAM_HEADERS: ['name', 'number', 'date_started', 'date_ended', 'active']

  initialize: ->
    console.log @_get_teams()

  _get_member_info: =>
    _.compact _.map @model.attributes, (v, k) =>
      unless _.contains @IGNORED_HEADERS, k
        attribute = db.Helpers.map_header k
        value = db.Helpers.clean_table_value v
        {attribute: attribute,value: value}

  _get_member_name: =>
    @model.get('name')

  _has_emergency_contacts: =>
    @model.get('emergency_contacts').length > 0

  _get_emergency_contacts: =>
    _.map @model.get('emergency_contacts'), (e) =>
      {contact_info:
        _.compact _.map e, (v, k) =>
          unless _.contains @IGNORED_EC_HEADERS, k
            attribute = db.Helpers.map_header k
            value = db.Helpers.clean_table_value v
            {attribute: attribute,value: value}}

  _has_teams: =>
    @model.get('players').length > 0

  _get_teams: =>
    _.map @model.get('players'), (e) =>
      team_info = {}
      _.each @TEAM_HEADERS, (h) =>
        value = db.Helpers.clean_table_value e[h]
        team_info[h] = value
      team_info
