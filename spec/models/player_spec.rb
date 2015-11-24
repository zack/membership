describe Player do
  describe 'associations' do
    it 'should belong to member' do
      should belong_to(:member)
    end

    it 'should have many team_players' do
      should have_many(:team_players)
    end

    it 'should have many teams' do
      should have_many(:teams).through(:team_players)
    end
  end

  describe 'validations' do
    # Because of a weird corner case in the should libary
    subject { Player.new(name: 'Myra', number: '1') }

    it 'should validate the presence of a name' do
      should validate_presence_of(:name)
    end

    it 'should validate uniqueness of name' do
      should validate_uniqueness_of(:name).scoped_to(:number).case_insensitive
    end

    it 'should validate the format of the number' do
      should allow_value('0').for(:number)
      should allow_value('00').for(:number)
      should allow_value('000').for(:number)
      should allow_value('0000').for(:number)
      should_not allow_value('0A').for(:number)
      should_not allow_value('A0').for(:number)
      should_not allow_value('0A00').for(:number)
      should_not allow_value('AAA0').for(:number)
      should_not allow_value('0AAA').for(:number)
      should_not allow_value('').for(:number)
      should_not allow_value('A').for(:number)
      should_not allow_value('AAAA').for(:number)
      should_not allow_value('AAAAA').for(:number)
      should_not allow_value('AAAA1').for(:number)
      should_not allow_value('11111').for(:number)
    end

    # Shoulda can't test this

    it 'should pass with just date_started' do
      expect(Player.count).to eq(0)
      Player.create(name: "Username Here",
                    number: "0",
                    date_started: Date.today)
      expect(Player.count).to eq(1)
    end

    it 'should pass with just date_ended' do
      expect(Player.count).to eq(0)
      Player.create(name: "Username Here",
                    number: "0",
                    date_ended: Date.today)
      expect(Player.count).to eq(1)
    end

    it 'should pass with date_ended after date_started' do
      expect(Player.count).to eq(0)
      Player.create(name: "Username Here",
                    number: "0",
                    date_started: Date.today - 1,
                    date_ended: Date.today)
      expect(Player.count).to eq(1)
    end

    it 'should pass with date_ended equal to date_started' do
      expect(Player.count).to eq(0)
      Player.create(name: "Username Here",
                    number: "0",
                    date_started: Date.today,
                    date_ended: Date.today)
      expect(Player.count).to eq(1)
    end

    it 'should fail with date_ended before date_started' do
      expect(Player.count).to eq(0)
      Player.create(name: "Username Here",
                    number: "0",
                    date_started: Date.today,
                    date_ended: Date.today - 1)
      expect(Player.count).to eq(0)
    end
  end
end
