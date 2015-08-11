describe TeamCaptain do
  describe 'associations' do
    it 'should belong to team_player' do
      should belong_to(:team_player)
    end
  end

  describe 'validations' do
    # Because of a weird corner case in the should libary
    subject { TeamCaptain.new(team_player_id: 1) }

    it 'should validate the presence of a team_player_id' do
      should validate_presence_of(:team_player_id)
    end

    it 'should validate the uniqueness of a team_player_id' do
      should validate_uniqueness_of(:team_player_id)
    end

    # Shoulda can't test this

    it 'should pass with just date_started' do
      expect(TeamCaptain.count).to eq(0)
      TeamCaptain.create(team_player_id: 1,
                         date_started: Date.today)
      expect(TeamCaptain.count).to eq(1)
    end

    it 'should pass with just date_ended' do
      expect(TeamCaptain.count).to eq(0)
      TeamCaptain.create(team_player_id: 1,
                         date_ended: Date.today)
      expect(TeamCaptain.count).to eq(1)
    end

    it 'should pass with date_ended after date_started' do
      expect(TeamCaptain.count).to eq(0)
      TeamCaptain.create(team_player_id: 1,
                         date_started: Date.today - 1,
                         date_ended: Date.today)
      expect(TeamCaptain.count).to eq(1)
    end

    it 'should pass with date_ended equal to date_started' do
      expect(TeamCaptain.count).to eq(0)
      TeamCaptain.create(team_player_id: 1,
                         date_started: Date.today,
                         date_ended: Date.today)
      expect(TeamCaptain.count).to eq(1)
    end

    it 'should fail with date_ended before date_started' do
      expect(TeamCaptain.count).to eq(0)
      TeamCaptain.create(team_player_id: 1,
                         date_started: Date.today,
                         date_ended: Date.today - 1)
      expect(TeamCaptain.count).to eq(0)
    end
  end
end
