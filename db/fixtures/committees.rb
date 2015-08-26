for i in 1..25 # seed 25 committees
  Committee.seed do |c|
    c.pillar_id = rand(5) + 1# 5 pillars seeded
    c.name = Faker::Commerce.department(1)
  end
end
