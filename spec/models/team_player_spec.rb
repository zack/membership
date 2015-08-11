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

    # Shoulda can't test this

    it 'should pass with just date_started' do
      expect(TeamPlayer.count).to eq(0)
      TeamPlayer.create(team_id: 1,
                    player_id: 1,
                    date_started: Date.today)
      expect(TeamPlayer.count).to eq(1)
    end

    it 'should pass with just date_ended' do
      expect(TeamPlayer.count).to eq(0)
      TeamPlayer.create(team_id: 1,
                    player_id: 1,
                    date_ended: Date.today)
      expect(TeamPlayer.count).to eq(1)
    end

    it 'should pass with date_ended after date_started' do
      expect(TeamPlayer.count).to eq(0)
      TeamPlayer.create(team_id: 1,
                    player_id: 1,
                    date_started: Date.today - 1,
                    date_ended: Date.today)
      expect(TeamPlayer.count).to eq(1)
    end

    it 'should pass with date_ended equal to date_started' do
      expect(TeamPlayer.count).to eq(0)
      TeamPlayer.create(team_id: 1,
                    player_id: 1,
                    date_started: Date.today,
                    date_ended: Date.today)
      expect(TeamPlayer.count).to eq(1)
    end

    it 'should fail with date_ended before date_started' do
      expect(TeamPlayer.count).to eq(0)
      TeamPlayer.create(team_id: 1,
                    player_id: 1,
                    date_started: Date.today,
                    date_ended: Date.today - 1)
      expect(TeamPlayer.count).to eq(0)
    end
  end
end
