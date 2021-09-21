# frozen_string_literal: true

'require relative'
require 'simplecov'
SimpleCov.start
require 'rspec'
require 'csv'
require 'BigDecimal'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchants_repository'
require './lib/items'
require './lib/item_repository'
require './lib/sales_analyst'
describe SalesAnalyst do
  describe '#initialize' do
    it 'creates an instance of SalesAnalyst' do
      se = SalesEngine.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sales_analyst = se.analyst

      expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    end

    it 'has readable attributes' do
      se = SalesEngine.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sales_analyst = se.analyst

      expect(sales_analyst.items).to be_an(Array)
      expect(sales_analyst.merchants).to be_an(Array)
      expect(sales_analyst.merch_item_hash).to be_a(Hash)
    end
  end

  describe '#average_items_per_merchant' do
    it 'returns the average number of items for sale per merchant' do
      se = SalesEngine.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sales_analyst = se.analyst

      expect(sales_analyst.average_items_per_merchant).to eq(2.88)
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'returns the standard deviation of items per merchant' do
      se = SalesEngine.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sales_analyst = se.analyst

      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'returns merchants with item counts above 1 standard deviation above mean' do
      se = SalesEngine.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sales_analyst = se.analyst

      expect(sales_analyst.merchants_with_high_item_count).to be_an(Array)
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'returns the average price of items for a particular merchant' do
      se = SalesEngine.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sales_analyst = se.analyst

      expect(sales_analyst.average_item_price_for_merchant(12334159)).to be_a(BigDecimal)
    end
  end

  describe "#average_average_item_price_for_merchant" do
    it 'returns the average price across all merchants' do
      se = SalesEngine.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sales_analyst = se.analyst

      expect(sales_analyst.average_average_item_price_for_merchant).to be_a(BigDecimal)
    end
  end

  describe "#average_price_all" do
    it 'calculates the average price of all items' do
      se = SalesEngine.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )
      sales_analyst = se.analyst

      expect(sales_analyst.average_price_all).to be_a(Float)
    end
  end

  describe "#average_price_standard_deviation" do
    it 'calculates the standard deviation of all items' do
      se = SalesEngine.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )
      sales_analyst = se.analyst

      expect(sales_analyst.average_price_standard_deviation).to be_a(Float)
    end
  end

  describe "#golden_items" do
    it 'returns an array of items that are more than 2 SD above average price' do
      se = SalesEngine.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sales_analyst = se.analyst

      expect(sales_analyst.golden_items).to be_a(Array)
    end
  end

  describe "#average_invoices_per_merchant" do
    it 'returns the average number of invoices per merchant' do
      se = SalesEngine.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )
      sales_analyst = se.analyst

      expect(sales_analyst.average_invoices_per_merchant).to be_a(Float)
      expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
    end
  end
end

  describe "#average_invoices_per_merchant_standard_deviation" do
    it 'calculates the standard deviation of invoices per merchant' do
      se = SalesEngine.new(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv'
      )

      sales_analyst = se.analyst
      expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to be_a(Float)
      expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
    end
  end

  describe "#top_merchants_by_invoice_count" do
    it 'returns an array of merchants with 2SD above mean number of invoices' do
    se = SalesEngine.new(
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv'
    )

      sales_analyst = se.analyst
      expect(sales_analyst.top_merchants_by_invoice_count).to be_a(Array)
    end
  end

  describe '#bottom_merchants_by_invoice_count' do
    it 'returns an array of merchants with 2SD below mean number of invoices' do
    se = SalesEngine.new(
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv'
    )

      sales_analyst = se.analyst
      expect(sales_analyst.bottom_merchants_by_invoice_count).to be_a[Array]
    end
  end

    describe '#invoice_status' do
      it 'calculates the percent of invoices with a given status' do
        se = SalesEngine.new(
          items: './data/items.csv',
          merchants: './data/merchants.csv',
          invoices: './data/invoices.csv'
      )

    sales_analyst = se.analyst
    expect(sales_analyst.invoice_status(:pending)).to eq(29.55)
    expect(sales_analyst.invoice_status(:shipped)).to eq(56.95)
    expect(sales_analyst.invoice_status(:returned)).to eq(13.5)
  end
end


#   # describe "#top_merchants_by_invoice_count" do
#   #   it 'returns merchants with invoices'
