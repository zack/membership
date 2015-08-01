describe TeamPlayer do
  describe 'associations' do
    it 'should belong to team' do
      should belong_to(:team)
    end

    it 'should belong_to player' do
      should belong_to(:player)
    end

    it 'should have one team captain' do
      should have_one(:team_captain)
    end
  end

  describe 'validations' do
    # Because of a weird corner case in the should libary
    subject { TeamPlayer.new(team_id: 1, player_id: 1) }

    it 'should validate the presence of a team_id' do
      should validate_presence_of(:team_id)
    end

    it 'should validate the presence of a player_id' do
      should validate_presence_of(:player_id)
    end

    it 'should validate the uniqueness of the team and player ids' do
      should validate_uniqueness_of(:player_id).scoped_to(:team_id)
    end

    # Shoulda can't test these
    it 'should fail with a string for an start_date' do
      expect(TeamPlayer.count).to eq(0)
      TeamPlayer.create(team_id: 1,
                        player_id: 1,
                        date_started: 'string')
      expect(TeamPlayer.count).to eq(0)
    end

    it 'should fail with a number for an start_date' do
      expect(TeamPlayer.count).to eq(0)
      TeamPlayer.create(team_id: 1,
                        player_id: 1,
                        date_started: 123)
      expect(TeamPlayer.count).to eq(0)
    end

    it 'should fail with a string for an end_date' do
      expect(TeamPlayer.count).to eq(0)
      TeamPlayer.create(team_id: 1,
                        player_id: 1,
                        date_ended: 'string')
      expect(TeamPlayer.count).to eq(0)
    end

    it 'should fail with a number for an end_date' do
      expect(TeamPlayer.count).to eq(0)
      TeamPlayer.create(team_id: 1,
                        player_id: 1,
                        date_ended: 123)
      expect(TeamPlayer.count).to eq(0)
    end

    it 'should fail with an end date before a start date' do
      expect(TeamPlayer.count).to eq(0)
      TeamPlayer.create(team_id: 1,
                        player_id: 1,
                        date_started: Date.today,
                        date_ended: Date.today - 1)
      expect(TeamPlayer.count).to eq(0)
    end
  end
end
