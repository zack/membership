class db.TeamsCollection extends Backbone.Collection
  model: db.Team

  comparator: (a, b)->
    if a.get('name') < b.get('name')
      return -1
    else if a.get('name') > b.get('name')
      return 1
    else
      return 0
