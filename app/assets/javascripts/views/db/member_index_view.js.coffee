class db.MemberIndexView extends Marionette.CompositeView
  template: ich.member_index
  id: 'member_index'
  class: 'member_index'
  childViewContainer: 'tbody'
  templateHelpers: ->
    table_headers: @TABLE_HEADERS

  TABLE_ATTRS: ['name', 'nickname', 'wftda_id_number', 'signed_league_bylaws',
                 'signed_wftda_waiver', 'signed_wftda_confidentiality', 'active']

  TABLE_HEADERS: ['Name', 'Nickname', 'WFTDA #', 'Bylaws', 'Waiver',
                  'Confidentiality', 'Active']

  events:
    'click td.link': '_handle_tdlink_click'

  getChildView: ->
    db.MemberIndexRowView

  childViewOptions: ->
    table_attrs: @TABLE_ATTRS

  _get_table_headers: =>
    _.map @TABLE_ATTRS, (h) =>
      db.Helpers.map_header(h)

  _handle_tdlink_click: (e) ->
    id = $(e.currentTarget).data('id')
    db.app.Router.navigate("members/#{id}", {trigger: true})
