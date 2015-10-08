class db.MemberView extends Marionette.ItemView
  template: ich.member

  onRender: ->
    console.log 'rendering member item view'
