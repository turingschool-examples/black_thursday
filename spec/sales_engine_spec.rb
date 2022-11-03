require './lib/item'
require './lib/merchant'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_engine'

RSpec.describe SalesEngine do

  describe '#initialize' do
    xit 'exists' do
      se = SalesEngine.new

      expect(se).to be_a SalesEngine
    end
  end

  describe '#from_csv' do
    it 'loads merchant data from csv files' do
      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
      mr = se.merchants

      expect(mr).to be_a MerchantRepository
      expect(se.merchants.all.size).to eq(475)
      se.merchants.all.each do |merchant|
        expect(merchant).to be_a(Merchant)
      end

      merchant = se.merchants.find_by_name('CJsDecor')

      expect(merchant).to be_a(Merchant)
      expect(merchant.name).to eq('CJsDecor')
    end

    it 'loads item data from csv files' do

      se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })

      ir = se.items

      expect(ir).to be_a ItemRepository
      # expect(ir.items.all.size).to eq(475)
      se.items.all.each do |item|
        expect(item).to be_a(Item)
      end

      item = se.items.find_by_name('Disney scrabble frames')

      expect(item).to be_a(Item)
      expect(item.name).to eq('Disney scrabble frames')
      expect(item.id).to eq(263395721)

      ir.update(263395721, {name: 'Walt Disney Scrabble'})
      require "pry"; binding.pry
      expect(item.name).to eq('Walt Disney Scrabble')
    end
  end
end
