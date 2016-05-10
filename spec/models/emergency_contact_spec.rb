describe EmergencyContact do
  describe 'associations' do
    it 'should belong to member' do
      should belong_to(:member)
    end
  end

  describe 'validations' do
    it 'validates the presence of name' do
      should validate_presence_of(:name)
    end

    it 'validates the presence of a member_id' do
      should validate_presence_of(:member_id)
    end
  end
end
