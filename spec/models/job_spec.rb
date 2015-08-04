describe Job do
  describe 'associations' do
    it 'belongs to committee' do
      should belong_to(:committee)
    end

    it 'has many member_job' do
      should have_many(:member_jobs)
    end

    it 'has many members through member_jobs' do
      should have_many(:members).through(:member_jobs)
    end
  end

  describe 'validations' do
    it 'should valicate the presence of a name' do
      should validate_presence_of(:name)
    end

    it 'should validate the presence of committee_id' do
      should validate_presence_of(:committee_id)
    end

    # Shoulda can't test this

    it 'should fail with hours_per_week_lower lower than hours_per_week_upper' do
      expect(Job.count).to eq(0)
      Job.create(name: 'President',
                 committee_id: 1,
                 hours_per_week_lower: 5,
                 hours_per_week_upper: 4)
      expect(Job.count).to eq(0)
    end

    it 'should fail with a string for start_date' do
      expect(Job.count).to eq(0)
      Job.create(name: 'President',
                 committee_id: 1,
                 date_started: 'string')
      expect(Job.count).to eq(0)
    end

    it 'should fail with a number for start_date' do
      expect(Job.count).to eq(0)
      Job.create(name: 'President',
                 committee_id: 1,
                 date_started: 123)
      expect(Job.count).to eq(0)
    end

    it 'should fail with a string for end_Date' do
      expect(Job.count).to eq(0)
      Job.create(name: 'President',
                 committee_id: 1,
                 date_ended: 'string')
      expect(Job.count).to eq(0)
    end

    it 'should fail with a number for end_date' do
      expect(Job.count).to eq(0)
      Job.create(name: 'President',
                 committee_id: 1,
                 date_ended: 123)
      expect(Job.count).to eq(0)
    end

    it 'should fail with an end date before a start date' do
      expect(Job.count).to eq(0)
      Job.create(name: 'President',
                 committee_id: 1,
                 date_started: Date.today,
                 date_ended: Date.today - 1)
      expect(Job.count).to eq(0)
    end
  end
end
