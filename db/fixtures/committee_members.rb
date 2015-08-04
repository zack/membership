def maybe
  [true, false].sample
end

for i in 0...25 # seed 25 committees
  j = rand(10)
  while j < 200
    CommitteeMember.seed do |c|
      days_since_started = rand(3650)

      c.committee_id = i
      c.member_id = j
      c.date_started = Date.today - days_since_started.days if maybe()
      c.date_ended = Date.today - rand(days_since_started + 1).days if maybe()
    end
    j += rand(9) + 1
  end
end
