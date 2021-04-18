require 'SimpleCOV'
require 'csv'
require './lib/sales_engine'
require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  describe 'Instance' do
    it 'exists' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
                               )
      mr = se.merchants

      expect(mr).to be_an_instance_of(MerchantRepository)
    end
  end

  describe '#all' do
    it 'returns an array of all merchant instances' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
                               )
      mr = se.merchants

      expect(mr.all[0].id).to eq(12334105)
    end
  end

  describe '#find_by_id' do
    it 'finds merchant by id' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
                               )
      mr = se.merchants

      expect(mr.find_by_id(12335573).name).to eq('retropostershop')
    end

    it 'returns nil if no id' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
                               )
      mr = se.merchants

      expect(mr.find_by_id(2113113113)).to eq(nil)
    end
  end

  describe '#find_by_name' do
    it 'finds a merchant by name' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
                               )
      mr = se.merchants

      expect(mr.find_by_name('retropostershop').id).to eq(12335573)
    end

    it 'returns nil if no name exists' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
                               )
      mr = se.merchants

      expect(mr.find_by_name('lawrencesmeademporium')).to eq(nil)
    end
  end

  describe '#find_all_by_name'
    it 'find all that includes fragment' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
                               )
      mr = se.merchants

      actual = mr.find_all_by_name('retro')[1].name

      expect(actual).to eq('retropostershop')
    end

    it 'returns empty array by default' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
                               )
      mr = se.merchants

      expect(mr.find_all_by_name('lawrence')).to eq([])
    end

  describe '#max_id_number_new' do
    it 'finds the current max id' do
      se = SalesEngine.from_csv(
          items: './data/items.csv',
          merchants: './data/merchants.csv'
                               )
      mr = se.merchants

      expect(mr.max_id_number_new).to eq(12337412)
    end
  end

  describe '#create' do
    it 'creates new merchant with given attributes' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
                               )
      mr = se.merchants

      lawrence = mr.create(name: 'lawrence')

      expect(lawrence).to be_an_instance_of(Merchant)
    end
  end

  describe '#update' do
    it 'updates name' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
                               )
      mr = se.merchants

      mr.update(12337411, name: 'lawrence')

      expect(mr.find_by_id(12337411).name).to eq('lawrence')
    end
  end

  describe '#delete' do
    it 'deletes a merchant via id' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
                               )
      mr = se.merchants

      mr.delete(12337411)

      expect(mr.find_by_id(12337411)).to eq(nil)
    end
  end
end
