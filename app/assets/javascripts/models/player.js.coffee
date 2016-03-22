class db.Player extends Backbone.Model
  url: ->
    return '/players/'

  toJSON: ->
    { player: _.clone( @attributes ) }
