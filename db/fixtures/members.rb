def maybe
  [true, false].sample
end

for i in 1..200 # seed 200 members
  name = Faker::Name.name
  year_joined = rand(11) + 2005

  Member.seed do |m|
    m.government_name = name
    m.street_name = name
    m.nickname = name.split(" ")[0]
    m.phone_number = Faker::Number.number(10) if maybe()
    m.forum_handle = name + Faker::Lorem.word if maybe()
    m.address = "#{Faker::Address.street_address}, #{Faker::Address.city}, "\
                "#{Faker::Address.state_abbr}, #{Faker::Address.zip}" if maybe()
    m.date_of_birth = Date.today - (rand(17156) + 6570).days if maybe() # 18-65
    m.wftda_id_number = Faker::Number.number(5) if maybe()
    m.primary_insurance = "#{Faker::Company.name} #{Faker::Company.suffix}" if maybe()
    m.signed_wftda_waiver = maybe() if maybe()
    m.signed_wftda_confidentiality = maybe() if maybe()
    m.signed_league_bylaws = maybe() if maybe()
    m.purchased_wftda_insurance = maybe() if maybe()
    m.passed_wftda_test = maybe() if maybe()
    m.active = maybe() if maybe()
    m.google_doc_access = maybe() if maybe()
    m.year_joined = year_joined if maybe()
    m.year_left = Faker::Number.between(year_joined, 2015) if maybe()
    m.reason_left = Faker::Lorem.paragraph if maybe()
  end
end
