describe CommitteeMember do
  describe 'validation' do
    context 'is valid' do
      it 'with duplicate member_id' do
        expect(CommitteeMember.count).to eq(0)
        CommitteeMember.create(committee_id: 1, member_id: 1)
        CommitteeMember.create(committee_id: 2, member_id: 1)
        expect(CommitteeMember.count).to eq(2)
      end

      it 'with duplicate committee' do
        expect(CommitteeMember.count).to eq(0)
        CommitteeMember.create(committee_id: 1, member_id: 1)
        CommitteeMember.create(committee_id: 1, member_id: 2)
        expect(CommitteeMember.count).to eq(2)
      end

      it 'with no start date or end date' do
        expect(CommitteeMember.count).to eq(0)
        CommitteeMember.create(member_id: 1, committee_id: 1)
        expect(CommitteeMember.count).to eq(1)
      end

      it 'with a start date and no end date' do
        expect(CommitteeMember.count).to eq(0)
        CommitteeMember.create(member_id: 1,
                               committee_id: 1,
                               date_started: Date.today)
        expect(CommitteeMember.count).to eq(1)
      end

      it 'with an end date and no start date' do
        expect(CommitteeMember.count).to eq(0)
        CommitteeMember.create(member_id: 1,
                               committee_id: 1,
                               date_ended: Date.today)
        expect(CommitteeMember.count).to eq(1)
      end

      it 'with an end date after a start date' do
        expect(CommitteeMember.count).to eq(0)
        CommitteeMember.create(member_id: 1,
                               committee_id: 1,
                               date_started: Date.today - 1,
                               date_ended: Date.today)
        expect(CommitteeMember.count).to eq(1)
      end
    end

    context 'is invalid' do
      it 'with duplicate member_id and committee_id' do
        expect(CommitteeMember.count).to eq(0)
        CommitteeMember.create(committee_id: 1, member_id: 1)
        CommitteeMember.create(committee_id: 1, member_id: 1)
        expect(CommitteeMember.count).to eq(1)
      end

      it 'without a member_id' do
        expect(CommitteeMember.count).to eq(0)
        CommitteeMember.create(committee_id: 1)
        expect(CommitteeMember.count).to eq(0)
      end

      it 'without a committee_id' do
        expect(CommitteeMember.count).to eq(0)
        CommitteeMember.create(member_id: 1)
        expect(CommitteeMember.count).to eq(0)
      end

      it 'with an end date before a start date' do
        expect(CommitteeMember.count).to eq(0)
        CommitteeMember.create(member_id: 1,
                               committee_id: 1,
                               date_started: Date.today,
                               date_ended: Date.today - 1)
        expect(CommitteeMember.count).to eq(0)
      end
    end
  end
end
