def maybe
  [true, false].sample
end

for i in 1..300 # we seed 300 players
  on_teams = []
  days_since_started = rand(3650)
  new_team = rand(5) + 1
  while on_teams.include?(new_team)
    new_team = rand(5) + 1
  end
  on_teams << new_team

  puts "teamplayer with player_id ", i, " and team_id ", new_team
  TeamPlayer.seed do |t|
    # Can't be on the same team twice
    t.team_id = new_team # we seed 5 teams
    t.player_id = i
    t.date_started = Date.today - days_since_started.days if maybe()
    t.date_ended = Date.today - rand(days_since_started + 1).days if maybe()
  end
end
