class db.PlayersCollection extends Backbone.Collection
  model: db.Player

  initialize: ->
    @use_name_comparator()

  use_number_comparator: (reverse = false) =>
    @reverse = reverse
    this.comparator = @number_comparator.bind(this)

  use_name_comparator: (reverse = false) =>
    @reverse = reverse
    this.comparator = @name_comparator.bind(this)

  name_comparator: (a, b) =>
    a_name = a.get('name').toLowerCase()
    b_name = b.get('name').toLowerCase()
    ret = 0
    if a_name < b_name
      ret = -1
    else if a_name > b_name
      ret = 1
    if @reverse
      ret *= -1
    ret

  number_comparator: (a, b, reverse = 0) =>
    a_number = "#{a.get('number')}"
    b_number = "#{b.get('number')}"
    ret = 0
    if a_number < b_number
      ret = -1
    else if a_number > b_number
      ret = 1
    if @reverse
      ret *= -1
    ret
