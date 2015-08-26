def maybe
  [true, false].sample
end

t_p_id = 1

for i in 1..5 # we seed 5 teams
  for i in 1..2 # 2 captains per team
    days_since_started = rand(3650)

    TeamCaptain.seed do |t|
      t.team_player_id = t_p_id # no idea how many team_players we have
      t.date_started = Date.today - days_since_started.days if maybe()
      t.date_ended = Date.today - rand(days_since_started + 1).days if maybe()
    end

    t_p_id += 1
  end
end
