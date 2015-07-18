100.times do |n|
  derby_name = Faker::Name.name
  email_address = Faker::Internet.email
  legal_name_first = Faker::Name.first_name
  legal_name_last = Faker::Name.last_name
  number = Faker::Number.hexadecimal(3).upcase
  wftda_number = Faker::Number.number(3) if [true, false].sample
  nickname = Faker::Name.first_name
  group = ['cosmonaughties', 'arkham_horrors', 'nutcrackers',
           'wicked_pissahs', 'travel_team', 'travel_and_recreational',
           'other'].sample(rand(2)+1)
  signed_wftda_waiver = [true, false].sample
  signed_wftda_confidentiality = [true, false].sample
  signed_league_bylaws = [true, false].sample
  wftda_id = Faker::Number.number(3)
  forum_name = Faker::Name.first_name
  year_joined = Faker::Number.between(2004, 2015)
  phone_number = Faker::PhoneNumber.phone_number
  emergency_contact_name_first = Faker::Name.first_name
  emergency_contact_name_last = Faker::Name.last_name
  emergency_contact_phone = Faker::PhoneNumber.phone_number
  emergency_contact_relation = Faker::Lorem.word
  date_of_birth = Faker::Time.between(18.years.ago, 60.years.ago)
  address_state = Faker::Address.state
  address_street = Faker::Address.street_address
  address_city = Faker::Address.city
  address_zip = Faker::Address.zip
  primary_insurance = Faker::Address.zip
  on_massacre = [true, false].sample
  on_travel_team = [true, false].sample
  league_job = Faker::Lorem.word
  purchased_wftda_insurance = [true, false].sample
  passed_wftda_test = [true, false].sample
  google_doc_access = [true, false].sample

  if [true, false].sample
    if [true, false].sample
      group.push('officials')
    else
      group = ['officials']
    end
    wftda_certification = Faker::Number.between(0, 5)
    official = true
    skating_official = [true, false].sample
  else
    official = false
  end

  if [true, false].sample
    group = ['former']
    status = 'Inactive'
    year_left = Faker::Number.between(year_joined,2015)
    reason_left = Faker::Lorem.sentence
  else
    status = 'Active'
  end

  Member.create!( derby_name: derby_name,
    email_address: email_address,
    legal_name_first: legal_name_first,
    legal_name_last: legal_name_last,
    number: number,
    wftda_number: wftda_number,
    nickname: nickname,
    group: group,
    signed_wftda_waiver: signed_wftda_waiver,
    signed_wftda_confidentiality: signed_wftda_confidentiality,
    signed_league_bylaws: signed_league_bylaws,
    wftda_id: wftda_id,
    forum_name: forum_name,
    year_joined: year_joined,
    year_left: year_left,
    reason_left: reason_left,
    phone_number: phone_number,
    emergency_contact_name_first: emergency_contact_name_first,
    emergency_contact_name_last: emergency_contact_name_last,
    emergency_contact_phone: emergency_contact_phone,
    emergency_contact_relation: emergency_contact_relation,
    date_of_birth: date_of_birth,
    address_state: address_state,
    address_street: address_street,
    address_city: address_city,
    address_zip: address_zip,
    primary_insurance: primary_insurance,
    status: status,
    on_massacre: on_massacre,
    on_travel_team: on_travel_team,
    league_job: league_job,
    purchased_wftda_insurance: purchased_wftda_insurance,
    passed_wftda_test: passed_wftda_test,
    google_doc_access: google_doc_access,
    official: official,
    wftda_certification: wftda_certification,
    skating_official: skating_official)
end
