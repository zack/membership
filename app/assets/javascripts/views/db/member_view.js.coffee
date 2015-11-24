class db.MemberView extends Marionette.ItemView
  template: ich.member
  id: 'member_view'
  templateHelpers: ->
    member_info: @_get_member_info
    name: @_get_member_name
    has_emergency_contacts: @_has_emergency_contacts
    emergency_contacts: @_get_emergency_contacts
    has_skater_profiles: @_has_skater_profiles
    skater_profiles: @_get_skater_profiles

  IGNORED_HEADERS: ['name', 'id', 'emergency_contacts', 'players']
  IGNORED_EC_HEADERS: ['id', 'member_id']

  PROFILE_HEADERS: ['name', 'number', 'date_started', 'date_ended', 'active']

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

  _has_skater_profiles: =>
    @model.get('players').length > 0

  _get_skater_profiles: =>
    _.flatten _.map @model.get('players'), (p) =>
      if p.teams.length > 0
        _.map p.teams, (t) =>
          @_build_profile_row(p, t)
      else
        @_build_profile_row(p, [name: null])

  _build_profile_row: (player, team) ->
    row = {team_name: team.name, team_id: team.id}

    _.each @PROFILE_HEADERS, (h) =>
      value = db.Helpers.clean_table_value player[h]
      row[h] = value

    row
