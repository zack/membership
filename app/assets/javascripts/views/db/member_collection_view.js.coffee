class db.MemberCollectionView extends Marionette.CompositeView
  template: ich.member_collection
  tagName: 'table'
  id: 'member-collection'
  childViewContainer: 'tbody'
  templateHelpers:
    tableHeaders: ['Name', 'Nickname', 'WFTDA ID', 'WFTDA League Bylaws',
                   'WFTDA Waiver', 'WFTDA Confidentiality']

  onRender: ->
    console.log 'rendering member collection view'

  getChildView: ->
    db.MemberView
