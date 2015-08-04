describe Committee do
  describe 'assocations' do
    it 'belongs to a pillar' do
      should belong_to(:pillar)
    end

    it 'has many jobs' do
      should have_many(:jobs)
    end

    it 'has many committee_members' do
      should have_many(:committee_members)
    end

    it 'has many members through committee_members' do
      should have_many(:members).through(:committee_members)
    end
  end

  describe 'validations' do
    # Because of a weird corner case in the should libary
    subject { Committee.new(name: 'Communications', pillar_id: 1) }

    it 'should validate presence of name' do
      should validate_presence_of(:name)
    end

    it 'should validate uniquness of name' do
      should validate_uniqueness_of(:name).case_insensitive
    end

    it 'should validate the presence of pillar_id' do
      should validate_presence_of(:pillar_id)
    end
  end
end
