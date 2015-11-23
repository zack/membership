class db.PlayersCollection extends Backbone.Collection
  model: db.Player

  comparator: (a, b)->
    if a.get('name') < b.get('name')
      return -1
    else if a.get('name') > b.get('name')
      return 1
    else
      return 0
