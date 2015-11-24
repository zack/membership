def maybe
  [true, false].sample
end

for i in 1..200 # seed 200 emergency contacts
  EmergencyContact.seed do |e|
    e.member_id = rand(200) + 1
    e.name = Faker::Name.name
    e.phone_number = Faker::Number.number(10)
    e.address = "#{Faker::Address.street_address}, #{Faker::Address.city}, "\
                "#{Faker::Address.state_abbr}, #{Faker::Address.zip}" if maybe()
    e.relationship = Faker::Lorem.word if maybe()
  end
end
