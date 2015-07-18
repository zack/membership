100.times do |n|
  legal_name  = Faker::Name.name
  derby_name  = Faker::Name.name
  email_address = "example-#{n+1}@bdd.org"
  Member.create!(legal_name:    legal_name,
                 derby_name:    derby_name,
                 email_address: email_address)
end
