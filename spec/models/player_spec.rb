describe Player do
  describe 'validation' do
    context 'is valid' do
      it 'with a name and number' do
        expect(Player.count).to eq(0)
        Player.create(name: 'Schneewittchen', number: '1')
        Player.create(name: 'Blick', number: '1A')
        Player.create(name: 'Flick', number: 'A1')
        Player.create(name: 'Glick', number: 'A1A')
        Player.create(name: 'Plick', number: '1111')
        Player.create(name: 'Quee', number: 'AAA1')
        Player.create(name: 'Snick', number: '1AAA')
        Player.create(name: 'Whick', number: '1AA1')
        expect(Player.count).to eq(8)
      end
    end

    context 'is invalid' do
      it 'without a name' do
        expect(Player.count).to eq(0)
        Player.create(number: '1')
        expect(Player.count).to eq(0)
      end

      it 'without a number' do
        expect(Player.count).to eq(0)
        Player.create(name: 'Kabo')
        expect(Player.count).to eq(0)
      end

      it 'with a number too short' do
        expect(Player.count).to eq(0)
        Player.create(name: 'Vint', number: '')
        expect(Player.count).to eq(0)
      end

      it 'with a number too long' do
        expect(Player.count).to eq(0)
        Player.create(name: 'Belle', number: 'AB123')
        expect(Player.count).to eq(0)
      end

      it 'with a number with illegal characters' do
        expect(Player.count).to eq(0)
        Player.create(name: 'Teryn', number: '-4')
        Player.create(name: 'Velly', number: '.45')
        expect(Player.count).to eq(0)
      end

      it 'with a digitless number' do
        expect(Player.count).to eq(0)
        Player.create(name: 'Darren', number: 'ABC')
        expect(Player.count).to eq(0)
      end

      it 'with a duplicate name and number' do
        expect(Player.count).to eq(0)
        Player.create(name: 'Red', number: '12')
        Player.create(name: 'Red', number: '12')
        expect(Player.count).to eq(1)
      end
    end
  end
end
