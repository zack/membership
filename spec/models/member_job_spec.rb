describe MemberJob do
  describe 'associations' do
    it 'should belong to member' do
      should belong_to(:member)
    end

    it 'should belong to job' do
      should belong_to(:job)
    end
  end

  describe 'validations' do
    # Because of a weird corner case in the should libary
    subject { MemberJob.new(member_id: 1) }

    it 'should validate presence of job_id' do
      should validate_presence_of(:job_id)
    end

    it 'should validate a unique job_id with member_id' do
      should validate_uniqueness_of(:job_id).scoped_to(:member_id)
    end

    it 'should validate the presence of member_id' do
      should validate_presence_of(:member_id)
    end
  end
end
