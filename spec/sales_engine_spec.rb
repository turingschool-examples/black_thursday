require 'rspec'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchants_repository'
require './lib/items'
require './lib/item_repository'
require 'csv'


<<<<<<< HEAD
=======
describe SalesEngine do

>>>>>>> 46f08309bdd33ebaca98e51906d08b7df68cf082
  describe '#initialize' do
    it 'creates an instance of SalesEngine' do
      se = SalesEngine.new({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv"
        })
      expect(se).to be_an_instance_of SalesEngine
    end
  end

  describe '#items' do
    it 'returns a new instance of ItemRepository with an array of item objects' do
      se = SalesEngine.new({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv"
        })
      ir = se.items
<<<<<<< HEAD

      expect(ir).to be_an_instance_of(ItemRepository)
    end
  end

  describe '#merchants' do
    it 'returns a new instance of MerchantRepository with an array of merchant objects' do
      se = SalesEngine.new({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv"
        })
      mr = se.merchants

=======

      expect(ir).to be_an_instance_of(ItemRepository)
    end
  end

  describe '#merchants' do
    it 'returns a new instance of MerchantRepository with an array of merchant objects' do
      se = SalesEngine.new({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv"
        })
      mr = se.merchants

>>>>>>> 46f08309bdd33ebaca98e51906d08b7df68cf082
      expect(mr).to be_an_instance_of(MerchantsRepository)
    end
  end

end
