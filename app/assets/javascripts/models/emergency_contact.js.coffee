class db.EmergencyContact extends Backbone.Model
  url: ->
    return '/emergency_contacts/'

  toJSON: ->
    { emergency_contact: _.clone( @attributes ) }
