describe Committee do
  describe 'validation' do
    context 'is valid' do
      it 'with a name' do
        expect {Committee.create(name: 'Laurie')}.to change(Committee, :count).by(1)
      end
    end

    context 'invalid' do
      it 'without a name' do
        expect {Committee.create()}.not_to change(Committee, :count)
      end

      it 'with a duplicate name' do
        Committee.create(name: 'Azar')
        expect {Committee.create(name: 'Azar')}.not_to change(Committee, :count)
      end

      it 'with a duplicate name regardless of case' do
        Committee.create(name: 'KERRY')
        expect {Committee.create(name: 'kerry')}.not_to change(Committee, :count)
      end
    end
  end
end
