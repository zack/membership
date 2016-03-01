class db.Member extends Backbone.Model
  url: ->
    return '/members/'

  toJSON: ->
    { member: _.clone( @attributes ) }
