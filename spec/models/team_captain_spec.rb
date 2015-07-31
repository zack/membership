describe TeamCaptain do
  describe 'validation' do
    context 'is valid' do
      it 'with team_player_id' do
        expect(TeamCaptain.count).to eq(0)
        TeamCaptain.create(team_player_id: 1)
        expect(TeamCaptain.count).to eq(1)
      end

      it 'with no start date or end date' do
        expect(TeamCaptain.count).to eq(0)
        TeamCaptain.create(team_player_id: 1)
        expect(TeamCaptain.count).to eq(1)
      end

      it 'with a start date and no end date' do
        expect(TeamCaptain.count).to eq(0)
        TeamCaptain.create(team_player_id: 1, date_started: Date.today)
        expect(TeamCaptain.count).to eq(1)
      end

      it 'with an end date and no start date' do
        expect(TeamCaptain.count).to eq(0)
        TeamCaptain.create(team_player_id: 1, date_ended: Date.today)
        expect(TeamCaptain.count).to eq(1)
      end

      it 'with an end date after a start date' do
        expect(TeamCaptain.count).to eq(0)
        TeamCaptain.create(team_player_id: 1,
                         date_started: Date.today - 1,
                         date_ended: Date.today)
        expect(TeamCaptain.count).to eq(1)
      end

    end
    context 'is invalid' do
      it 'with duplicate team_player_id' do
        expect(TeamCaptain.count).to eq(0)
        TeamCaptain.create(team_player_id: 1)
        TeamCaptain.create(team_player_id: 1)
        expect(TeamCaptain.count).to eq(1)
      end

      it 'without a team_player_id' do
        expect(TeamCaptain.count).to eq(0)
        TeamCaptain.create()
        expect(TeamCaptain.count).to eq(0)
      end

      it 'with an end date before a start date' do
        expect(TeamCaptain.count).to eq(0)
        TeamCaptain.create(team_player_id: 1,
                         date_started: Date.today,
                         date_ended: Date.today - 1)
        expect(TeamCaptain.count).to eq(0)
      end
    end
  end
end
