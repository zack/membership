describe EmergencyContact do
  describe 'validation' do
    context 'is valid' do
      it 'with a name and phone_number' do
        expect(EmergencyContact.count).to eq(0)
        EmergencyContact.create(name: 'Sean', phone_number: '7814430314')
        expect(EmergencyContact.count).to eq(1)
      end
    end

    context 'is invalid' do
      it 'without a name' do
        expect(EmergencyContact.count).to eq(0)
        EmergencyContact.create(phone_number: '7814430314')
        expect(EmergencyContact.count).to eq(0)
      end

      it 'without a phone_number' do
        expect(EmergencyContact.count).to eq(0)
        EmergencyContact.create(name: 'Gregg')
        expect(EmergencyContact.count).to eq(0)
      end

      it 'with a phone number too shoart' do
        expect(EmergencyContact.count).to eq(0)
        EmergencyContact.create(phone_number: '012345678')
        expect(EmergencyContact.count).to eq(0)
      end

      it 'with a phone number too long' do
        expect(EmergencyContact.count).to eq(0)
        EmergencyContact.create(phone_number: '01234567890')
        expect(EmergencyContact.count).to eq(0)
      end

      it 'with a phone number with a letter' do
        expect(EmergencyContact.count).to eq(0)
        EmergencyContact.create(phone_number: '012345678A')
        expect(EmergencyContact.count).to eq(0)
      end

      it 'with a phone number with punctuation' do
        expect(EmergencyContact.count).to eq(0)
        EmergencyContact.create(phone_number: '0123456+.-')
        expect(EmergencyContact.count).to eq(0)
      end
    end
  end
end
