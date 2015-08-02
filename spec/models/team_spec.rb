describe Team do
  describe 'associations' do
    it 'have many team_players' do
      should have_many(:team_players)
    end

    it 'have many players through team players' do
      should have_many(:players).through(:team_players)
    end
  end
  describe 'validations' do
    it 'should validate the presence of a name' do
      should validate_presence_of(:name)
    end

    it 'should validate the uniqueness of a name' do
      should validate_uniqueness_of(:name).case_insensitive
    end

    # Shoulda can't test these

    it 'should fail with a string for an start_date' do
      expect(Team.count).to eq(0)
      Team.create(name: 'Toasters',
                  date_started: 'string')
      expect(Team.count).to eq(0)
    end

    it 'should fail with a number for an start_date' do
      expect(Team.count).to eq(0)
      Team.create(name: 'Toasters',
                  date_started: 123)
      expect(Team.count).to eq(0)
    end

    it 'should fail with a string for an end_date' do
      expect(Team.count).to eq(0)
      Team.create(name: 'Toasters',
                  date_ended: 'string')
      expect(Team.count).to eq(0)
    end

    it 'should fail with a number for an end_date' do
      expect(Team.count).to eq(0)
      Team.create(name: 'Toasters',
                  date_ended: 123)
      expect(Team.count).to eq(0)
    end

    it 'should fail with an end date before a start date' do
      expect(Team.count).to eq(0)
      Team.create(name: 'Toasters',
                  date_started: Date.today,
                  date_ended: Date.today - 1)
      expect(Team.count).to eq(0)
    end
  end
end
