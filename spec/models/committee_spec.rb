describe Committee do
  describe 'validation' do
    context 'is valid' do
      it 'with a name' do
        expect(Committee.count).to eq(0)
        Committee.create(name: 'Communications')
        expect(Committee.count).to eq(1)
      end
    end

    context 'is invalid' do
      it 'without a name' do
        expect(Committee.count).to eq(0)
        Committee.create()
        expect(Committee.count).to eq(0)
      end

      it 'with a duplicate name' do
        expect(Committee.count).to eq(0)
        Committee.create(name: 'Communications')
        Committee.create(name: 'Communications')
        expect(Committee.count).to eq(1)
      end

      it 'with a duplicate name regardless of case' do
        expect(Committee.count).to eq(0)
        Committee.create(name: 'communications')
        Committee.create(name: 'COMMUNICATIONS')
        expect(Committee.count).to eq(1)
      end
    end
  end
end
