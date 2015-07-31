describe Member do
  describe 'validation' do
    context 'is valid' do
      it 'with a name' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Avela')
        expect(Member.count).to eq(1)
      end

      it 'with a unique forum handle' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Avela', forum_handle: 'avela932')
        expect(Member.count).to eq(1)
      end

      it 'with a unique wftda_id_number' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Avela', wftda_id_number: 10484)
        expect(Member.count).to eq(1)
      end

      it 'with a start year and no end year' do
        expect(Member.count).to eq(0)
        Member.create!(name: 'Avela', year_joined: 2015)
        expect(Member.count).to eq(1)
      end

      it 'with an end year and no start year' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Avela', year_left: 2015)
        expect(Member.count).to eq(1)
      end

      it 'with an end year identical to a start year' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Avela',
                      year_joined: 2015,
                      year_left: 2015)
        expect(Member.count).to eq(1)
      end

      it 'with an end year after a start year' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Avela',
                      year_joined: 2014,
                      year_left: 2015)
        expect(Member.count).to eq(1)
      end
    end

    context 'is invalid' do
      it 'without a name' do
        expect(Member.count).to eq(0)
        Member.create()
        expect(Member.count).to eq(0)
      end

      it 'with a duplicate forum handle, ignoring case' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Avela', forum_handle: 'a932')
        Member.create(name: 'Arnie', forum_handle: 'A932')
        expect(Member.count).to eq(1)
      end

      it 'with a duplicate wftda_id_number' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Alex', wftda_id_number: 10484)
        Member.create(name: 'Tyrone', wftda_id_number: 10484)
        expect(Member.count).to eq(1)
      end

      it 'with a non-numerical wftda_id_number' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Andy', wftda_id_number: 'identifier')
        expect(Member.count).to eq(0)
      end

      it 'with a non-integer wftda_id_number' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Andy', wftda_id_number: 10484.1)
        expect(Member.count).to eq(0)
      end

      it 'with a non-numerical year_joined' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Alice', year_joined: 'identifier')
        expect(Member.count).to eq(0)
      end

      it 'with a non-numerical year_left' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Kenny', year_left: 'identifier')
        expect(Member.count).to eq(0)
      end

      it 'with a non-integer year_joined' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Anu', year_joined: 2015.1)
        expect(Member.count).to eq(0)
      end

      it 'with a non-integer year_left' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Treshma', year_left: 2015.1)
        expect(Member.count).to eq(0)
      end

      it 'with an end year before a start year' do
        expect(Member.count).to eq(0)
        Member.create(name: 'Avela',
                      year_joined: 2015,
                      year_left: 2014)
        expect(Member.count).to eq(0)
      end
    end
  end
end
