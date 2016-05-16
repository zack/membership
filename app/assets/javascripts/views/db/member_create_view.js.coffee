class db.MemberCreateView extends Marionette.CompositeView
  template: ich.member_create
  className: 'member-create-view'

  events: ->
    'click .submit' : 'submit'
    'keydown input' : 'handle_input_keydown'

  handle_input_keydown: (e) ->
    $(e.currentTarget).removeClass('error')
    if e.which == 13
      @submit()

  submit: ->
    if @_all_inputs_are_filled()
      data = @_get_member_data()
      new db.Member().save data,
        success: @_handle_save_success
        error: @_handle_save_error
    else
      @_highlight_empty_inputs()

  _all_inputs_are_filled: ->
    filled_inputs = _.compact(_.map($('input'), (elem) -> $(elem).val()))
    filled_inputs.length == $('input').length

  _highlight_empty_inputs: ->
    empty_inputs = _.filter($('input'), (elem) -> $(elem).val().length == 0)
    console.log empty_inputs
    _.each empty_inputs, (elem) -> $(elem).addClass('error')

  _get_member_data: ->
    member = {}
    _.each $('input'), (elem) ->
      attribute = $(elem).attr('attr')
      value = $(elem).val()
      member[attribute] = value
    member

  _handle_save_success: (model) ->
    member_id = model.attributes.member.id
    db.app.Router.navigate("members/#{member_id}", {trigger: true})

  _handle_save_error: ->
    console.log 'error'
