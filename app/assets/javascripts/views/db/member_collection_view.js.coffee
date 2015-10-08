class db.MemberCollectionView extends Marionette.CompositeView
  template: ich.member_collection
  tagName: 'table'
  id: 'member-collection'
  #childView: db.MemberView
  childViewContainer: 'tbody'

  onRender: ->
    console.log 'rendering member collection view'

  getChildView: ->
    db.MemberView
