class db.MemberCollectionView extends Marionette.CompositeView
  template: ich.member_collection
  childView: db.MemberView
  childViewContainer: '.childview-container'

  onRender: ->
    console.log 'rendering member collection view'
