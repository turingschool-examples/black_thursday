require 'pry'
require 'simplecov'
require 'rspec'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

SimpleCov.start

RSpec.describe SalesAnalyst do
  context 'iteration 1' do
    it 'exists' do
      sa = SalesAnalyst.new(1, 2, 3, 4, 5, 6)
      expect(sa).to be_a(SalesAnalyst)
    end
    before :each do
      @sales_engine = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv",
                                             :transactions => "./data/transactions.csv", :invoice_items => "./data/invoice_items.csv", :invoices => "./data/invoices.csv", :customers => "./data/customers.csv" })
      @sales_analyst = @sales_engine.analyst
    end

    it 'groups items by merchant id' do
      @sales_analyst.group_items_by_merchant_id
      expect(@sales_analyst.merchant_items_hash.count).to eq(475)
      expect(@sales_analyst.merchant_items_hash.class).to eq(Hash)
    end

    it 'makes a list of the number of items offered by each merchant' do
      @sales_analyst.items_per_merchant
      expect(@sales_analyst.num_items_per_merchant.class).to be(Array)
      expect(@sales_analyst.num_items_per_merchant.count).to be(475)
      expect(@sales_analyst.num_items_per_merchant.sum).to be(1367)
    end

    it 'what is the average items per merchant' do
      expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
    end

    it 'collects squared differences of each item count and mean of item counts' do
      @sales_analyst.square_differences
      expect(@sales_analyst.set_of_square_differences.count).to eq(475)
      expect(@sales_analyst.set_of_square_differences.class).to eq(Array)
      expect(@sales_analyst.set_of_square_differences[0].class).to eq(Float)
    end

    it 'what is the standard deviation' do
      expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end

    it 'which merchants have above one st. dev. avg products offered' do
      expect(@sales_analyst.merchants_with_high_item_count.class).to eq(Array)
      sample1 = @sales_analyst.merchant_repo.find_by_id(@sales_analyst.merchants_with_high_item_count[0].id).id
      sample2 = @sales_analyst.merchant_repo.find_by_id(@sales_analyst.merchants_with_high_item_count[1].id).id
      sample3 = @sales_analyst.merchant_repo.find_by_id(@sales_analyst.merchants_with_high_item_count[2].id).id
      expect(@sales_analyst.group_items_by_merchant_id[sample1].count).to be > 6.14
      expect(@sales_analyst.group_items_by_merchant_id[sample2].count).to be > 6.14
      expect(@sales_analyst.group_items_by_merchant_id[sample3].count).to be > 6.14
    end


    it 'what is the avg item price for a merchant' do
      @sales_analyst.merchants_with_high_item_count
      sample1 = @sales_analyst.big_box_ids[0]
      sample2 = @sales_analyst.big_box_ids[1]
      expect(@sales_analyst.average_item_price_for_merchant(sample1).class).to eq(BigDecimal)
      expect(@sales_analyst.average_item_price_for_merchant(sample2).class).to eq(BigDecimal)
    end

    it 'what is the avg avg price for a merchant' do
      expect(@sales_analyst.average_average_price_for_merchant.class).to eq(BigDecimal)
    end

    it 'average_item_price_standard_deviation' do
      expect(@sales_analyst.average_item_price_standard_deviation).to be_a(Float
      end)

    xit 'what items are over two st. devs above avg item price' do
      expect(@sales_analyst.golden_items).to eq("ummmmm i don't know")
    end
  end
end
