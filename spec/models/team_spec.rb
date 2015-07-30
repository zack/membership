describe Team do
  describe 'validation' do
    context 'is valid' do
      it 'with a name' do # and no date
        expect(Team.count).to eq(0)
        Team.create(name: 'Massacre')
        expect(Team.count).to eq(1)
      end

      it 'with an end date and no start date' do
        expect(Team.count).to eq(0)
        Team.create(name: 'Massacre', date_ended: Date.today)
        expect(Team.count).to eq(1)
      end

      it 'with an end date after a start date' do
        expect(Team.count).to eq(0)
        Team.create(name: 'Massacre',
                    date_started: Date.today - 1,
                    date_ended: Date.today)
        expect(Team.count).to eq(1)
      end
    end

    context 'is invalid' do
      it 'without a name' do
        expect(Team.count).to eq(0)
        Team.create()
        expect(Team.count).to eq(0)
      end

      it 'with a duplicate name' do
        expect(Team.count).to eq(0)
        Team.create(name: 'Massacre')
        Team.create(name: 'Massacre')
        expect(Team.count).to eq(1)
      end

      it 'with a duplicate name regardless of case' do
        expect(Team.count).to eq(0)
        Team.create(name: 'massacre')
        Team.create(name: 'MASSACRE')
        expect(Team.count).to eq(1)
      end

      it 'with an end date before a start date' do
        Team.create(name: 'Massacre',
                    date_started: Date.today,
                    date_ended: Date.today - 1)
        expect(Team.count).to eq(0)
      end
    end
  end
end
