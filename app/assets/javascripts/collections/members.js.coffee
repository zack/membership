class db.MembersCollection extends Backbone.Collection
  model: db.Member

  url: '/members/'

  comparator: (a, b)->
    a_name = a.get('nickname').toLowerCase()
    b_name = b.get('nickname').toLowerCase()

    if a_name < b_name
      return -1
    else if a_name > b_name
      return 1
    else
      return 0
