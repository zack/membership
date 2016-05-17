class db.MembersCollection extends Backbone.Collection
  model: db.Member

  url: '/members/'

  comparator: (a, b)->
    if a.get('nickname') < b.get('nickname')
      return -1
    else if a.get('nickname') > b.get('nickname')
      return 1
    else
      return 0
