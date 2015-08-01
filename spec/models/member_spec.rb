describe Member do
  describe 'associations' do
    it 'has many players' do
      should have_many(:players)
    end

    it 'has many emergency_contacts' do
      should have_many(:emergency_contacts)
    end

    it 'should have many member_jobs' do
      should have_many(:member_jobs)
    end

    it 'should have many jobs through member_jobs' do
      should have_many(:jobs).through(:member_jobs)
    end

    it 'should have many committee_members' do
      should have_many(:committee_members)
    end

    it 'should have many committees through commmittee_members' do
      should have_many(:committees).through(:committee_members)
    end
  end
  describe 'validations' do
    # Because of a weird corner case in the should libary
    subject { Member.new(name: 'Trish') }

    it 'validate presence of name' do
      should validate_presence_of(:name)
    end

    it 'validates uniqueness of forum_handle' do
      should validate_uniqueness_of(:forum_handle).case_insensitive.allow_nil
    end

    it 'should validate the uniqueness of wftda_id_number' do
      should validate_uniqueness_of(:wftda_id_number).allow_nil
    end

    it 'should validate numericality of wftda_id_number' do
      should validate_numericality_of(:wftda_id_number).allow_nil
    end

    it 'should validate numericality and integerness of year_joined' do
      should validate_numericality_of(:year_joined).only_integer.allow_nil
    end

    it 'should validate numericality and integerness of year_left' do
      should validate_numericality_of(:year_left).only_integer.allow_nil
    end

    # Shoulda can't test greater_or_equal_to against other attributes
    it 'should fail with an end year before a start year' do
      expect(Member.count).to eq(0)
      Member.create(name: 'Avela',
                    year_joined: 2015,
                    year_left: 2014)
      expect(Member.count).to eq(0)
    end
  end
end
