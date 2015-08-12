def maybe
  [true, false].sample
end

for i in 0...200 # seed 200 jobs
  Job.seed do |j|
    days_since_started = rand(3650)
    hours_per_week_lower = rand(10)

    j.committee_id = rand(25)
    j.name = Faker::Name.title
    j.is_full_time = maybe()
    j.hours_per_week_lower = hours_per_week_lower if maybe()
    j.hours_per_week_upper = rand(9) + 1 if maybe()
    j.date_started = Date.today - days_since_started.days if maybe()
    j.date_ended = Date.today - rand(days_since_started + 1).days if maybe()
  end
end
