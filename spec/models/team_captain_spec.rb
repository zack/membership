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

    # Shoulda can't test these
    it 'should fail with a string for an start_date' do
      expect(TeamCaptain.count).to eq(0)
      TeamCaptain.create(team_player_id: 1,
                        date_started: 'string')
      expect(TeamCaptain.count).to eq(0)
    end

    it 'should fail with a number for an start_date' do
      expect(TeamCaptain.count).to eq(0)
      TeamCaptain.create(team_player_id: 1,
                        date_started: 123)
      expect(TeamCaptain.count).to eq(0)
    end

    it 'should fail with a string for an end_date' do
      expect(TeamCaptain.count).to eq(0)
      TeamCaptain.create(team_player_id: 1,
                        date_ended: 'string')
      expect(TeamCaptain.count).to eq(0)
    end

    it 'should fail with a number for an end_date' do
      expect(TeamCaptain.count).to eq(0)
      TeamCaptain.create(team_player_id: 1,
                        date_ended: 123)
      expect(TeamCaptain.count).to eq(0)
    end

    it 'should fail with an end date before a start date' do
      expect(TeamCaptain.count).to eq(0)
      TeamCaptain.create(team_player_id: 1,
                        date_started: Date.today,
                        date_ended: Date.today - 1)
      expect(TeamCaptain.count).to eq(0)
    end
  end
end
