class db.MembersCollection extends Backbone.Collection
  model: db.Member

  comparator: (a, b)->
    if a.get('name') < b.get('name')
      return -1
    else if a.get('name') > b.get('name')
      return 1
    else
      return 0
