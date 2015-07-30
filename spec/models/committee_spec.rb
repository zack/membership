describe Committee do
  describe 'validation' do
    it 'is valid with a name' do
      expect {Committee.create(name: 'Laurie')}.to change(Committee, :count).by(1)
    end

    it 'is invalid without a name' do
      expect {Committee.create()}.not_to change(Committee, :count)
    end

    it 'is invalid with a duplicate name' do
      Committee.create(name: 'Azar')
      expect {Committee.create(name: 'Azar')}.not_to change(Committee, :count)
    end

    it 'ignores case with name validation' do
      Committee.create(name: 'KERRY')
      expect {Committee.create(name: 'kerry')}.not_to change(Committee, :count)
    end
  end
end
