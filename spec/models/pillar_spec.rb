describe Pillar do
  describe 'validation' do
    context 'is valid' do
      it 'with a unique name' do
        expect(Pillar.count).to eq(0)
        Pillar.create(name: 'Finance')
        expect(Pillar.count).to eq(1)
      end
    end

    context 'is invalid' do
      it 'with a duplicate name' do
        expect(Pillar.count).to eq(0)
        Pillar.create(name: 'Finance')
        Pillar.create(name: 'Finance')
        expect(Pillar.count).to eq(1)
      end
    end
  end
end
