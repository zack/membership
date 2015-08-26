def maybe
  [true, false].sample
end

for i in 1..200 # seed 200 jobs
  days_since_started = rand(3650)
  hours_per_week_lower = rand(10)

  Job.seed do |j|
    j.committee_id = rand(25)
    j.name = Faker::Name.title
    j.is_full_time = maybe()
    j.hours_per_week_lower = hours_per_week_lower if maybe()
    j.hours_per_week_upper = hours_per_week_lower + rand(5) if maybe()
    j.date_started = Date.today - days_since_started.days if maybe()
    j.date_ended = Date.today - rand(days_since_started + 1).days if maybe()
  end
end
