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

    # Shoulda can't test this

    it 'should fail with a string for start_date' do
      expect(MemberJob.count).to eq(0)
      MemberJob.create(member_id: 1,
                       job_id: 1,
                       date_started: 'string')
      expect(MemberJob.count).to eq(0)
    end

    it 'should fail with a number for start_date' do
      expect(MemberJob.count).to eq(0)
      MemberJob.create(member_id: 1,
                       job_id: 1,
                       date_started: 123)
      expect(MemberJob.count).to eq(0)
    end

    it 'should fail with a string for end_Date' do
      expect(MemberJob.count).to eq(0)
      MemberJob.create(member_id: 1,
                       job_id: 1,
                       date_ended: 'string')
      expect(MemberJob.count).to eq(0)
    end

    it 'should fail with a number for end_date' do
      expect(MemberJob.count).to eq(0)
      MemberJob.create(member_id: 1,
                       job_id: 1,
                       date_ended: 123)
      expect(MemberJob.count).to eq(0)
    end

    it 'should fail with an end date before a start date' do
      expect(MemberJob.count).to eq(0)
      MemberJob.create(member_id: 1,
                       job_id: 1,
                       date_started: Date.today,
                       date_ended: Date.today - 1)
      expect(MemberJob.count).to eq(0)
    end
  end
end
