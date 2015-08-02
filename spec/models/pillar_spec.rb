describe Pillar do
  describe 'associations' do
    it 'has many committees' do
      should have_many(:committees)
    end
  end

  describe 'validations' do
    it 'should validate presence' do
      should validate_presence_of(:name)
    end

    it 'should validate uniqueness' do
      should validate_uniqueness_of(:name).case_insensitive
    end
  end
end
