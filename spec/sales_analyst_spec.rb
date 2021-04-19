require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice'
require 'bigdecimal/util'

RSpec.describe do

  describe 'initialize' do
    # require 'pry';binding.pry
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./spec/fixtures/items_fixtures.csv",
                                        :merchants => "./spec/fixtures/merchants_fixtures.csv",
                                        :invoices => "./spec/fixtures/invoices_fixtures.csv",
                                        :invoice_items => "./spec/fixtures/invoice_items_fixtures.csv",
                                        :customers => "./data/customers.csv",
                                        :transactions => "./data/transactions.csv"
                                        })
    sales_analyst = sales_engine.analyst

    it 'exists' do
      expect(sales_analyst.engine).to be_an_instance_of(SalesEngine)
    end

    it 'looks up all merchants' do
      expect(sales_analyst.merchants[1]).to be_an_instance_of(Merchant)
    end

    it 'looks up all items' do
      expect(sales_analyst.items[1]).to be_an_instance_of(Item)
    end

    it 'calculates average_items_per_merchant' do
      first_ten_merchants = sales_engine.merchants.array_of_objects[0..9]
      allow(sales_analyst).to receive(:merchants) do
        first_ten_merchants
      end
      # Average of 2.5 was verified by searching fixture file with first 10 ID's
      expect(sales_analyst.average_items_per_merchant).to eq(2.5)
    end

    it 'returns standard deviation of merchant item count' do
      expected_array = [12334105,12334112,12334113,12334115,12334123,12334132,12334135,12334141,12334144,12334145]
      first_ten_merchants = sales_engine.merchants.array_of_objects[0..9]
      allow(sales_analyst).to receive(:average_items_per_merchant) do
        2.5
      end
      allow(sales_analyst).to receive(:merchants) do
        first_ten_merchants
      end

      expect(sales_analyst.average_items_per_merchant_standard_deviation).to be_between(3, 6)
      #Check above expected ranges after we figure out the standard deviation sample size issue
    end

    it 'returns merchants with high item count' do
      expected_array = [12334105,12334112,12334113,12334115,12334123,12334132,12334135,12334141,12334144,12334145]
      first_ten_merchants = sales_engine.merchants.array_of_objects[0..9]
      expected_merchant = first_ten_merchants[4]
      allow(sales_analyst).to receive(:merchants) do
        first_ten_merchants
      end

      expect(sales_analyst.merchants_with_high_item_count).to eq([expected_merchant])
    end

    it 'returns average item price per merchant' do
      expected_price = 0.10147e3.to_d

      expect(sales_analyst.average_item_price_for_merchant(12334123)).to eq(expected_price)
    end

    it 'averages all average prices per merchant' do
      first_ten_merchants = sales_engine.merchants.array_of_objects[0..9]
      allow(sales_analyst).to receive(:merchants) do
        first_ten_merchants
      end

      expect(sales_analyst.average_average_price_per_merchant).to eq(0.3335e2)
    end

    it 'has special golden items for funny reasons' do
      first_20_items = sales_engine.items.array_of_objects[0..19]
      allow(sales_analyst).to receive(:items) do
        first_20_items
      end

      expect(sales_analyst.golden_items.length).to eq(1)

    end
  end

  describe 'iteration 2 functionality' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./spec/fixtures/items_fixtures.csv",
                                        :merchants => "./spec/fixtures/merchants_fixtures.csv",
                                        :invoices => "./data/invoices.csv",
                                        :invoice_items => "./spec/fixtures/invoice_items_fixtures.csv",                                        :customers => "./data/customers.csv",
                                        :transactions => "./data/transactions.csv"
                                        })
    sales_analyst = sales_engine.analyst

    it '#average_invoices_per_merchant' do
      expect(sales_analyst.average_invoices_per_merchant).to eq(11.25)
    end

    it 'calculates invoices per merchant standard deviation' do
      expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(4.02)
    end

    it '#top days by invoice count' do
      expect(sales_analyst.top_days_by_invoice_count).to eq(["Wednesday"])
    end

    it '#calculates invoice status' do
      expect(sales_analyst.invoice_status(:pending)).to eq(29.55)
      expect(sales_analyst.invoice_status(:shipped)).to eq(56.95)
      expect(sales_analyst.invoice_status(:returned)).to eq(13.5)
    end

    it 'returns top merchants by invoice count' do
      expect(sales_analyst.top_merchants_by_invoice_count.length).to eq(2)
      expect(sales_analyst.top_merchants_by_invoice_count.first.class).to eq(Merchant)
    end

    it 'returns bottom merchants by invoice count' do
      expect(sales_analyst.bottom_merchants_by_invoice_count.length).to eq(1)
      expect(sales_analyst.bottom_merchants_by_invoice_count.first.class).to eq(Merchant)
    end
  end
end
