require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'

RSpec.describe do

  describe 'initialize' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./spec/fixtures/items_fixtures.csv",
                                        :merchants => "./spec/fixtures/merchants_fixtures.csv",
                                        })
    sales_analyst = sales_engine.analyst

    it 'exists' do
      expect(sales_analyst.engine).to be_an_instance_of(SalesEngine)
    end

    it 'looks up all merchants' do
      expect(sales_analyst.find_all_merchants[1]).to be_an_instance_of(Merchant)
    end

    it 'looks up all items' do
      expect(sales_analyst.find_all_items[1]).to be_an_instance_of(Item)
    end

    it 'calculates average_items_per_merchant' do
      #Need to decide how to test this. Stub? Fixture data set?
      expect(sales_analyst.average_items_per_merchant).to be_an_instance_of(Float)
    end

    it 'returns set of ten merchant ids' do
      first_ten_merchants = sales_engine.merchants.array_of_objects[0..9]

      expected_array = [12334105,12334112,12334113,12334115,12334123,12334132,12334135,12334141,12334144,12334145]
      allow(sales_analyst.find_all_merchants).to receive(:sample) do
        first_ten_merchants
      end

      expect(sales_analyst.sample_merchants_return_id).to eq(expected_array)
    end
    # it 'looks up all items a merchant sells by id lookup' do
    #   expect(sales_analyst.merchant_items_lookup(500000)).to eq(nil)
    #   expect(sales_analyst.merchant_items_lookup(12334105).name).to eq("Shopin1901")
    # end
  end
end
# mock_merchants = [                                                     | 22   def average_items_per_merchant_standard_deviation
#                   Merchant.new{id: 12334155, name: 'DesignerEstore' },                 | 23     std_dev_arry = []
#                   Merchant.new{id: 12334159, name: 'SassyStrangeArt'},                 | 24     counter = 0
#                   Merchant.new{id: 12334160, name: 'byMarieinLondon'},                 | 25     merch_sample = find_all_merchants.sample(10)
#                   Merchant.new{id: 12334165, name: 'JUSTEmonsters'},                   | 26     merchant_ids = merch_sample.map do |merchant|
#                   Merchant.new{id: 12334174, name: 'Uniford'},                         | 27       merchant.id
#                   Merchant.new{id: 12334176, name: 'thepurplepenshop'},                | 28     end
#                   Merchant.new{id: 12334183, name: 'handicraftgallery'},               | 29     merchant_items = []
#                   Merchant.new{id: 12334185, name: 'Madewithgitterxx'},                | 30     random_items = merchant_ids.each do |merchant_id|
#                   Merchant.new{id: 12334189, name: 'JacquieMann'},                     | 31       merchant_items << find_all_by_merchant_id(merchant_id).length
#                   Merchant.new{id: 12334193, name: 'TheHamAndRat'}                     | 32     end
#                   ]
