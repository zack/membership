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

    it 'should validate the presence of phone number' do
      should validate_presence_of(:phone_number)
    end

    it 'should validate the format of phone number' do
      should allow_value('0003334444').for(:phone_number)
      should_not allow_value('003334444').for(:phone_number)
      should_not allow_value('00003334444').for(:phone_number)
      should_not allow_value('R0003334444').for(:phone_number)
    end
  end
end
