describe Player do
  describe 'associations' do
    it 'should belong to member' do
      should belong_to(:member)
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
      should allow_value('0A').for(:number)
      should allow_value('A0').for(:number)
      should allow_value('0A00').for(:number)
      should allow_value('AAA0').for(:number)
      should allow_value('0AAA').for(:number)
      should_not allow_value('').for(:number)
      should_not allow_value('A').for(:number)
      should_not allow_value('AAAA').for(:number)
      should_not allow_value('AAAAA').for(:number)
      should_not allow_value('AAAA1').for(:number)
      should_not allow_value('11111').for(:number)
    end
  end
end
