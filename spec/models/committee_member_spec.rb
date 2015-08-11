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

    it 'should pass without date_started or date_ended' do
      expect(CommitteeMember.count).to eq(0)
      CommitteeMember.create!(member_id: 1, committee_id: 1)
      expect(CommitteeMember.count).to eq(1)
    end

    it 'should pass with only date_started' do
      expect(CommitteeMember.count).to eq(0)
      CommitteeMember.create(member_id: 1,
                             committee_id: 1,
                             date_started: Date.today)
      expect(CommitteeMember.count).to eq(1)
    end

    it 'should pass with only date_ended' do
      expect(CommitteeMember.count).to eq(0)
      CommitteeMember.create(member_id: 1,
                             committee_id: 1,
                             date_ended: Date.today)
      expect(CommitteeMember.count).to eq(1)
    end

    it 'should pass with date_started before date_ended' do
      expect(CommitteeMember.count).to eq(0)
      CommitteeMember.create(member_id: 1,
                             committee_id: 1,
                             date_started: Date.today - 1,
                             date_ended: Date.today)
      expect(CommitteeMember.count).to eq(1)
    end

    it 'should pass with date_started equal to date_ended' do
      expect(CommitteeMember.count).to eq(0)
      CommitteeMember.create(member_id: 1,
                             committee_id: 1,
                             date_started: Date.today,
                             date_ended: Date.today)
      expect(CommitteeMember.count).to eq(1)
    end

    it 'should fail with date_started after to date_ended' do
      expect(CommitteeMember.count).to eq(0)
      CommitteeMember.create(member_id: 1,
                             committee_id: 1,
                             date_started: Date.today,
                             date_ended: Date.today - 1)
      expect(CommitteeMember.count).to eq(0)
    end
  end
end
