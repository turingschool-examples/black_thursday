require 'csv'
require_realative 'sales_engine'
require_relative 'repository'

RSpec.describe Repository do
  describe 'Instance' do
    it 'exists' do
      rep = Repository.new([], 'engine')

      expect(rep).to be_an_instance_of(Repository)
    end
  end

  describe '#all' do
    it 'returns everything in its array' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      mr = se.merchants

      expect(mr.all[0].name).to eq('Shopin1901')
    end
  end

  describe '#find_by_id' do
    it 'finds merchant by id' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      mr = se.merchants

      expect(mr.find_by_id('12335573').name).to eq('retropostershop')
    end

    it 'returns nil if no id' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      mr = se.merchants

      expect(mr.find_by_id('2113113113')).to eq(nil)
    end
  end

  describe '#find_by_name' do
    it 'finds a merchant by name' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      mr = se.merchants

      expect(mr.find_by_name('retropostershop').id).to eq('12335573')
    end

    it 'returns nil if no name exists' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      mr = se.merchants

      expect(mr.find_by_name('lawrencesmeademporium')).to eq(nil)
    end
  end

  describe '#max_id_number_new' do
    it 'finds the current max id' do
      se = SalesEngine.from_csv(
          items: './data/items.csv',
          merchants: './data/merchants.csv'
      )
      mr = se.merchants

      expect(mr.max_id_number_new).to eq('12337412')
    end
  end

  describe '#delete' do
    it 'deletes a merchant via id' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      mr = se.merchants

      mr.delete('12337411')

      expect(mr.find_by_id('12337411')).to eq(nil)
    end
  end
end
