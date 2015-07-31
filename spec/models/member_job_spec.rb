describe MemberJob do
  describe 'validation' do
    context 'is valid' do
      it 'with duplicate member_id' do
        expect(MemberJob.count).to eq(0)
        MemberJob.create(member_id: 1, job_id: 1)
        MemberJob.create(member_id: 1, job_id: 2)
        expect(MemberJob.count).to eq(2)
      end

      it 'with duplicate job_id' do
        expect(MemberJob.count).to eq(0)
        MemberJob.create(member_id: 1, job_id: 1)
        MemberJob.create(member_id: 2, job_id: 1)
        expect(MemberJob.count).to eq(2)
      end

      it 'with no start date or end date' do
        expect(MemberJob.count).to eq(0)
        MemberJob.create(member_id: 1, job_id: 1)
        expect(MemberJob.count).to eq(1)
      end

      it 'with a start date and no end date' do
        expect(MemberJob.count).to eq(0)
        MemberJob.create(member_id: 1, job_id: 1, date_started: Date.today)
        expect(MemberJob.count).to eq(1)
      end

      it 'with an end date and no start date' do
        expect(MemberJob.count).to eq(0)
        MemberJob.create(member_id: 1, job_id: 1, date_ended: Date.today)
        expect(MemberJob.count).to eq(1)
      end

      it 'with an end date after a start date' do
        expect(MemberJob.count).to eq(0)
        MemberJob.create(member_id: 1,
                         job_id: 1,
                         date_started: Date.today - 1,
                         date_ended: Date.today)
        expect(MemberJob.count).to eq(1)
      end

    end
    context 'is invalid' do
      it 'without a member_id' do
        expect(MemberJob.count).to eq(0)
        MemberJob.create(job_id: 1)
        expect(MemberJob.count).to eq(0)
      end

      it 'without a job_id' do
        expect(MemberJob.count).to eq(0)
        MemberJob.create(member_id: 1)
        expect(MemberJob.count).to eq(0)
      end

      it 'with duplicate member_id and job_id' do
        expect(MemberJob.count).to eq(0)
        MemberJob.create(member_id: 1, job_id: 1)
        MemberJob.create(member_id: 1, job_id: 1)
        expect(MemberJob.count).to eq(1)
      end

      it 'with an end date before a start date' do
        expect(MemberJob.count).to eq(0)
        MemberJob.create(member_id: 1,
                         job_id: 1,
                         date_started: Date.today,
                         date_ended: Date.today - 1)
        expect(MemberJob.count).to eq(0)
      end
    end
  end
end
