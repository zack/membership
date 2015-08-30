def maybe
  [true, false].sample
end

for i in 1..300 # seed 300 players
  days_since_started = rand(3650)

  Player.seed do |p|
    p.member_id = rand(200) + 1 # we seed 200 members
    p.name = Faker::Name.title
    p.number = rand(65535).to_s(36) # not perfect, but close enough.
    p.date_started = Date.today - days_since_started.days if maybe()
    p.date_ended = Date.today - rand(days_since_started + 1).days if maybe()
  end
end