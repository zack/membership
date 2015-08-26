def maybe
  [true, false].sample
end

for i in 1..25 # seed 25 committees
  j = rand(10) + 1
  while j < 200
    days_since_started = rand(3650)

    CommitteeMember.seed do |c|
      c.committee_id = i
      c.member_id = j
      c.date_started = Date.today - days_since_started.days if maybe()
      c.date_ended = Date.today - rand(days_since_started + 1).days if maybe()
    end

    j += rand(10) + 1
  end
end
