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

    # Shoulda can't test this

    it 'should pass with just date_started' do
      expect(Team.count).to eq(0)
      Team.create(name: "Toasters",
                  date_started: Date.today)
      expect(Team.count).to eq(1)
    end

    it 'should pass with just date_ended' do
      expect(Team.count).to eq(0)
      Team.create(name: "Toasters",
                  date_ended: Date.today)
      expect(Team.count).to eq(1)
    end

    it 'should pass with date_ended after date_started' do
      expect(Team.count).to eq(0)
      Team.create(name: "Toasters",
                  date_started: Date.today - 1,
                  date_ended: Date.today)
      expect(Team.count).to eq(1)
    end

    it 'should pass with date_ended equal to date_started' do
      expect(Team.count).to eq(0)
      Team.create(name: "Toasters",
                  date_started: Date.today,
                  date_ended: Date.today)
      expect(Team.count).to eq(1)
    end

    it 'should fail with date_ended before date_started' do
      expect(Team.count).to eq(0)
      Team.create(name: "Toasters",
                  date_started: Date.today,
                  date_ended: Date.today - 1)
      expect(Team.count).to eq(0)
    end
  end
end
