def maybe
  [true, false].sample
end

taken_jobs = []
m_id = 1 # member_id

while m_id <= 200
  days_since_started = rand(3650)
  job_id = rand(200) + 1
  while taken_jobs.include?(job_id)
    job_id = rand(200) + 1
  end
  taken_jobs << job_id

  MemberJob.seed do |m|
    m.member_id = m_id
    m.job_id = job_id
    m.date_started = Date.today - days_since_started.days if maybe()
    m.date_ended = Date.today - rand(days_since_started + 1).days if maybe()
  end

  m_id += rand(5) + 1
end
