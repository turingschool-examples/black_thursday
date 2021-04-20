require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice'
require 'bigdecimal/util'

RSpec.describe do

  describe 'initialize' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./spec/fixtures/items_fixtures.csv",
                                        :merchants => "./spec/fixtures/merchants_fixtures.csv",
                                        :invoices => "./data/invoices.csv",
                                        :invoice_items => "./data/invoice_items.csv",
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
                                        :invoice_items => "./spec/fixtures/invoice_items_fixtures.csv",
                                        :transactions => "./data/transactions.csv",
                                        :customers => "./data/customers.csv"
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

  describe 'iteration 3 functionality' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./spec/fixtures/items_fixtures.csv",
                                        :merchants => "./spec/fixtures/merchants_fixtures.csv",
                                        :invoices => "./data/invoices.csv",
                                        :invoice_items => "./spec/fixtures/invoice_items_fixtures.csv",
                                        :transactions => "./data/transactions.csv",
                                        :customers => "./data/customers.csv"
                                        })

    sales_analyst = sales_engine.analyst

    it '#invoice_paid_in_full? returns true if invoice is paid in full' do

      expect(sales_analyst.invoice_paid_in_full?(1)).to eq(true)
      expect(sales_analyst.invoice_paid_in_full?(200)).to eq(true)
      expect(sales_analyst.invoice_paid_in_full?(203)).to eq(false)
      expect(sales_analyst.invoice_paid_in_full?(204)).to eq(false)
    end

    it '#invoice_total returns total dollar amount of invoice by id IF the invoice is paid in full' do

      expect(sales_analyst.invoice_total(1)).to eq(21067.77)
      expect(sales_analyst.invoice_total(1).class).to eq(BigDecimal)
      expect(sales_analyst.invoice_total(2)).to eq(5289.13)
    end
  end

  describe 'AM iteration 4 functionality: revenue_by_merchant + top_revenue_earners' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./spec/fixtures/items_fixtures.csv",
                                        # :merchants => "./spec/fixtures/merchants_fixtures.csv",
                                        :merchants => "./data/merchants.csv",
                                        :invoices => "./data/invoices.csv",
                                        # :invoice_items => "./spec/fixtures/invoice_items_fixtures.csv",
                                        :invoice_items => "./data/invoice_items.csv",
                                        :transactions => "./data/transactions.csv",
                                        :customers => "./data/customers.csv"
                                        })
    sales_analyst = sales_engine.analyst

    it '#revenue_by_merchant returns total revenut for a given merchant' do
      # expect(sales_analyst.revenue_by_merchant(12334634)).to eq(0.19252887e6)
      # expect(sales_analyst.revenue_by_merchant(12334105)).to eq(106170.51)
      expect(sales_analyst.revenue_by_merchant(12334634).class).to eq(BigDecimal)
    end

    it '#top_revenue_earners(x) returns the x merchants with highest revenue' do
      expected = sales_analyst.top_revenue_earners(10)

      expect(expected[0]).to be_an_instance_of(Merchant)
      expect(expected.length).to eq(10)
      expect(expected[0].id).to eq(12334634)
      expect(expected.last.id).to eq(12335747)
    end

    it '#top_revenue_earners() returns the top 20 merchants with highest revenue' do
      expected = sales_analyst.top_revenue_earners

      expect(expected[0]).to be_an_instance_of(Merchant)
      expect(expected.length).to eq(20)
      expect(expected[0].id).to eq(12334634)
      expect(expected.last.id).to eq(12334159)
    end
  end

  describe 'iteration 4 functionality' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./spec/fixtures/items_fixtures.csv",
                                        :merchants => "./spec/fixtures/merchants_fixtures.csv",
                                        :invoices => "./data/invoices.csv",
                                        :invoice_items => "./data/invoice_items.csv",
                                        :customers => "./data/customers.csv",
                                        :transactions => "./data/transactions.csv"
                                        })
    sales_analyst = sales_engine.analyst

    it 'populates total revenue by date' do
      expect(sales_analyst.total_revenue_by_date(Time.parse("2009-02-07"))).to eq(21067.77)
      expect(sales_analyst.total_revenue_by_date(Time.parse("2009-02-07")).class).to eq(BigDecimal)
    end

    it '#merchants_with_pending_invoices returns those merchants' do

      expect(sales_analyst.merchants_with_pending_invoices.length).to eq(39)
      expect(sales_analyst.merchants_with_pending_invoices[0].class).to eq(Merchant)
    end
  end

  describe 'alex describe block yo' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./data/items.csv",
                                        :merchants => "./data/merchants.csv",
                                        :invoices => "./data/invoices.csv",
                                        :invoice_items => "./data/invoice_items.csv",
                                        :transactions => "./data/transactions.csv",
                                        :customers => "./data/customers.csv"
                                        })
    sales_analyst = sales_engine.analyst

    it "#merchants_with_only_one_item returns merchants with only one item" do
      expected = sales_analyst.merchants_with_only_one_item

      expect(expected.length).to eq 243
      expect(expected.first.class).to eq Merchant
    end

    it "helper method invoices per month" do

      # expect(sales_analyst.merchants_by_month_hash.class).to eq(Hash)
      expect(sales_analyst.does_merchant_have_one_item_in_given_month?("January", 12334365)).to eq(false)
    end

    it "#merchants_with_only_one_item_registered_in_month returns merchants with only one invoice in given month" do
      # expected = sales_analyst.merchants_with_only_one_item_registered_in_month("March")
      expected = sales_analyst.merchants_by_month_hash["March"]
      expect(expected.length).to eq 21
      # expect(expected.first.class).to eq Merchant

      expected = sales_analyst.merchants_with_only_one_item_registered_in_month("June")

      expect(expected.length).to eq 18
      # expect(expected.first.class).to eq Merchant
    end
  end #keep this for Alex please and thank you
end
