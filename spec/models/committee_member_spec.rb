describe CommitteeMember do
  describe 'associations' do
    it 'should belong to committee' do
      should belong_to(:committee)
    end

    it 'should belong_to member' do
      should belong_to(:member)
    end
  end

  describe 'validations' do
    # Because of a weird corner case in the should libary
    subject { CommitteeMember.new(committee_id: 1, member_id: 1) }

    it 'should validate the presence of a committee id' do
      should validate_presence_of(:committee_id)
    end

    it 'should validate the presence of a member_id' do
      should validate_presence_of(:member_id)
    end

    it 'should validate the uniqueness of the committee and member ids' do
      should validate_uniqueness_of(:member_id).scoped_to(:committee_id)
    end

    # Shoulda can't test these
    it 'should fail with a string for an start_date' do
      expect(CommitteeMember.count).to eq(0)
      CommitteeMember.create(member_id: 1,
                             committee_id: 1,
                             date_started: 'string')
      expect(CommitteeMember.count).to eq(0)
    end

    it 'should fail with a number for an start_date' do
      expect(CommitteeMember.count).to eq(0)
      CommitteeMember.create(member_id: 1,
                             committee_id: 1,
                             date_started: 123)
      expect(CommitteeMember.count).to eq(0)
    end

    it 'should fail with a string for an end_date' do
      expect(CommitteeMember.count).to eq(0)
      CommitteeMember.create(member_id: 1,
                             committee_id: 1,
                             date_ended: 'string')
      expect(CommitteeMember.count).to eq(0)
    end

    it 'should fail with a number for an end_date' do
      expect(CommitteeMember.count).to eq(0)
      CommitteeMember.create(member_id: 1,
                             committee_id: 1,
                             date_ended: 123)
      expect(CommitteeMember.count).to eq(0)
    end

    it 'should fail with an end date before a start date' do
      expect(CommitteeMember.count).to eq(0)
      CommitteeMember.create(member_id: 1,
                             committee_id: 1,
                             date_started: Date.today,
                             date_ended: Date.today - 1)
      expect(CommitteeMember.count).to eq(0)
    end
  end
end
