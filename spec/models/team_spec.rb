describe Team do
  describe 'validation' do
    context 'valid' do
      it 'is valid with a name' do # and no date
        expect {Team.create(name: 'Massacre')}.to change(Team, :count).by(1)
      end

      it 'is valid with an end date and no start date' do
        expect {Team.create(name: 'Massacre', date_ended: Date.today)}.
               to change(Team, :count).by(1)
      end

      it 'is valid with an end date after a start date' do
        expect {Team.create(name: 'Massacre',
                            date_started: Date.today - 1,
                            date_ended: Date.today)}.
               to change(Team, :count).by(1)
      end
    end

    context 'invalid' do
      it 'is invalid without a name' do
        expect {Team.create()}.not_to change(Team, :count)
      end

      it 'is invalid with a duplicate name' do
        Team.create!(name: 'Massacre')
        expect {Team.create(name: 'Massacre')}.not_to change(Team, :count)
      end

      it 'ignores case with name validation' do
        Team.create!(name: 'MASSACRE')
        expect {Team.create(name: 'massacre')}.not_to change(Team, :count)
      end

      it 'is invalid with an end date before a start date' do
        expect {Team.create(name: 'Massacre',
                            date_started: Date.today,
                            date_ended: Date.today - 1)}.
               not_to change(Team, :count)
      end
    end
  end
end
