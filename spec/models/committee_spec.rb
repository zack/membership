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
    it 'should validate presence of name' do
      should validate_presence_of(:name)
    end

    it 'should validate uniquness of name' do
      should validate_uniqueness_of(:name).case_insensitive
    end
  end
end
