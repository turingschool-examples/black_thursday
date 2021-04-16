require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'

RSpec.describe SalesEngine do
  describe '#initialization' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./data/items.csv",
                                        :merchants => "./data/merchants.csv",
                                        })
    it 'exists' do
      expect(sales_engine).to be_instance_of(SalesEngine)
    end
  end

    # xit 'makes a hash' do
    #   expect(sales_engine.merchants).to eq("./data/merchants.csv")
    # end
    #
    # xit 'parse csv merchants' do
    #   expect(SalesEngine.parse_csv("./data/merchants.csv")).to be_instance_of(Array)
    # end
    #
    # # it 'parse csv items' do
    # #   expect(SalesEngine.parse_csv("./data/items.csv")).to be_instance_of(Array)
    # # end
    #
    # it 'creates hashes' do
    #   expect(SalesEngine.parse_csv("./data/merchants.csv")[0]).to be_instance_of(Hash)
    # end

  describe '#items & #merchants' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./data/items.csv",
                                        :merchants => "./data/merchants.csv",
                                        })

    it 'returns an object of class MerchantRepository' do
      expect(sales_engine.merchants).to be_an_instance_of(MerchantRepository)
    end

    it 'returns an object of class ItemRepository' do
      expect(sales_engine.items).to be_an_instance_of(ItemRepository)
    end

  end
end
