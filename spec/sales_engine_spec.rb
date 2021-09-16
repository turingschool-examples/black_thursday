require 'rspec'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchants_repository'
require './lib/items'
require './lib/item_repository'
require 'csv'

<<<<<<< HEAD

=======
>>>>>>> 4547c51c2ccc47623ccade40ea258bd77301cfa6
describe SalesEngine do

  describe '#initialize' do
    it 'creates an instance of SalesEngine' do
      se = SalesEngine.new({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv"
        })
      expect(se).to be_an_instance_of SalesEngine
    end

<<<<<<< HEAD
    it 'has readable attributes' do
=======
  describe '#items' do
    it 'returns a new instance of ItemRepository with an array of item objects' do
      se = SalesEngine.new({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv"
        })
      ir = se.items

      expect(ir).to be_an_instance_of(ItemRepository)
    end
  end

  describe '#merchants' do
    it 'returns a new instance of MerchantRepository with an array of merchant objects' do
>>>>>>> 4547c51c2ccc47623ccade40ea258bd77301cfa6
      se = SalesEngine.new({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv"
        })
<<<<<<< HEAD
      expect(se.merchants).to be_an_instance_of(MerchantsRepository)
      expect(se.items).to be_an_instance_of(ItemRepository)
=======
      mr = se.merchants

      expect(mr).to be_an_instance_of(MerchantsRepository)
>>>>>>> 4547c51c2ccc47623ccade40ea258bd77301cfa6
    end
  end

end
