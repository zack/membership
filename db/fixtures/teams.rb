def maybe
  [true, false].sample
end

for i in 0...5 # we seed 5 teams
  Team.seed do |t|
    days_since_started = rand(3650)

    t.name = "#{Faker::Hacker.adjective.capitalize} #{Faker::Team.creature.capitalize}"
    t.date_started = Date.today - days_since_started.days if maybe()
    t.date_ended = Date.today - rand(days_since_started + 1).days if maybe()
  end
end
