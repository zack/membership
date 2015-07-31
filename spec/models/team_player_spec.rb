describe TeamPlayer do
  describe 'validation' do
    context 'is valid' do
      it 'with team_id and player_id' do
        expect(TeamPlayer.count).to eq(0)
        TeamPlayer.create(team_id: 1, player_id: 1)
        expect(TeamPlayer.count).to eq(1)
      end

      it 'with no start date or end date' do
        expect(TeamPlayer.count).to eq(0)
        TeamPlayer.create(team_id: 1, player_id: 1)
        expect(TeamPlayer.count).to eq(1)
      end

      it 'with a start date and no end date' do
        expect(TeamPlayer.count).to eq(0)
        TeamPlayer.create(team_id: 1, player_id: 1, date_started: Date.today)
        expect(TeamPlayer.count).to eq(1)
      end

      it 'with an end date and no start date' do
        expect(TeamPlayer.count).to eq(0)
        TeamPlayer.create(team_id: 1, player_id: 1, date_ended: Date.today)
        expect(TeamPlayer.count).to eq(1)
      end

      it 'with an end date after a start date' do
        expect(TeamPlayer.count).to eq(0)
        TeamPlayer.create(team_id: 1,
                          player_id: 1,
                          date_started: Date.today - 1,
                          date_ended: Date.today)
        expect(TeamPlayer.count).to eq(1)
      end
    end

    context 'is invalid' do
      it 'with duplicate player_id and player_id' do
        expect(TeamPlayer.count).to eq(0)
        TeamPlayer.create(team_id: 1, player_id: 1)
        TeamPlayer.create(team_id: 1, player_id: 1)
        expect(TeamPlayer.count).to eq(1)
      end

      it 'without a team_id' do
        expect(TeamPlayer.count).to eq(0)
        TeamPlayer.create(player_id: 1)
        expect(TeamPlayer.count).to eq(0)
      end

      it 'without a player_id' do
        expect(TeamPlayer.count).to eq(0)
        TeamPlayer.create(team_id: 1)
        expect(TeamPlayer.count).to eq(0)
      end

      it 'with an end date before a start date' do
        expect(TeamPlayer.count).to eq(0)
        TeamPlayer.create(team_id: 1,
                          player_id: 1,
                         date_started: Date.today,
                         date_ended: Date.today - 1)
        expect(TeamPlayer.count).to eq(0)
      end
    end
  end
end
