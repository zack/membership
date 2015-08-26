def maybe
  [true, false].sample
end

for i in 1..5 # we seed 5 teams
  days_since_started = rand(3650)

  Team.seed do |t|
    t.name = "#{Faker::Hacker.adjective.capitalize} #{Faker::Team.creature.capitalize}"
    t.date_started = Date.today - days_since_started.days if maybe()
    t.date_ended = Date.today - rand(days_since_started + 1).days if maybe()
  end
end
