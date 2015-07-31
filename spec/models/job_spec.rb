describe Job do
  describe 'validation' do
    context 'is valid' do
      it 'with no start date or end date' do
        expect(Job.count).to eq(0)
        Job.create(name: 'Rosaline')
        expect(Job.count).to eq(1)
      end

      it 'with a start date and no end date' do
        expect(Job.count).to eq(0)
        Job.create(name: 'Rosaline',
                   date_started: Date.today)
        expect(Job.count).to eq(1)
      end

      it 'with an end date and no start date' do
        expect(Job.count).to eq(0)
        Job.create(name: 'Rosaline',
                   date_started: Date.today)
        expect(Job.count).to eq(1)
      end

      it 'with an end date after a start date' do
        expect(Job.count).to eq(0)
        Job.create(name: 'Rosaline',
                   date_started: Date.today - 1,
                   date_ended: Date.today)
        expect(Job.count).to eq(1)
      end

    end
    context 'is invalid' do
      it 'without a name' do
        expect(Job.count).to eq(0)
        Job.create()
        expect(Job.count).to eq(0)
      end

      it 'with an end date before a start date' do
        expect(Job.count).to eq(0)
        Job.create(name: 'Rosaline',
                   date_started: Date.today,
                   date_ended: Date.today - 1)
        expect(Job.count).to eq(0)
      end
    end
  end
end
