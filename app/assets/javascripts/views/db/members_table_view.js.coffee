class db.MembersTableView extends Marionette.CompositeView
  template: ich.members_table
  tagName: 'table'
  id: 'member-collection'
  class: 'members_table'
  childViewContainer: 'tbody'
  templateHelpers:
    tableHeaders: ['Name', 'Nickname', 'WFTDA ID', 'WFTDA League Bylaws',
                   'WFTDA Waiver', 'WFTDA Confidentiality']

  getChildView: ->
    db.MembersTableRowView
