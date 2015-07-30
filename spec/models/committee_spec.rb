describe Committee do
  describe 'validation' do
    context 'is valid' do
      it 'with a name' do
        expect(Committee.count).to eq(0)
        Committee.create(name: 'Laurie')
        expect(Committee.count).to eq(1)
      end
    end

    context 'invalid' do
      it 'without a name' do
        expect(Committee.count).to eq(0)
        Committee.create()
        expect(Committee.count).to eq(0)
      end

      it 'with a duplicate name' do
        expect(Committee.count).to eq(0)
        Committee.create(name: 'Azar')
        Committee.create(name: 'Azar')
        expect(Committee.count).to eq(1)
      end

      it 'with a duplicate name regardless of case' do
        expect(Committee.count).to eq(0)
        Committee.create(name: 'kerry')
        Committee.create(name: 'KERRY')
        expect(Committee.count).to eq(1)
      end
    end
  end
end
