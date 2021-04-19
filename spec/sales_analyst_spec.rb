require "CSV"
require "RSpec"
require "./lib/sales_engine"
require "./lib/item"
require "./lib/item_repo"
require "./lib/merchant_repo"
require "./lib/sales_analyst"

RSpec.describe SalesAnalyst do
  before(:each) do
    @sales_engine = SalesEngine.from_csv({:items => './data/items.csv',
                                          :merchants => './data/merchants.csv',
                                          :invoices => './data/invoices.csv',
                                          :invoice_items => './data/invoice_items.csv',
                                          :transactions  => './data/transactions.csv',
                                          :customers => './data/customers.csv'
                                        })
  end

  describe 'instantiation' do
    it '::new' do
      sales_analyst = @sales_engine.analyst
      
      expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    end
  end

  describe 'methods' do

    it '#total items' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.total_items).to eq(1367.0)
    end

    it '#total merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.total_merchants).to eq(475.0)
    end

    it '#average items per merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_items_per_merchant).to eq(2.88)
    end

    it '#average items price' do
      sales_analyst = @sales_engine.analyst
      
      expect(sales_analyst.average_item_price.class).to eq(Float)
    end

    it '#item count per merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.item_count_per_merchant.class).to eq(Hash)
    end

    it '#standard deviation items per merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end

    it '#standard deviation items price' do
      sales_analyst = @sales_engine.analyst
      
      expect(sales_analyst.average_item_price_standard_deviation).to eq(2899.93)
    end

    it '#merchant with highest item count' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.merchants_with_high_item_count.length).to eq(52)
    end

    it '#average item price for merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq(16.66)
    end

    it '#average average price per merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_average_price_per_merchant).to eq(350.29)
    end

    it '#golden items' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.golden_items.length).to eq 5
      expect(sales_analyst.golden_items.first.class).to eq Item
    end
  end
end
