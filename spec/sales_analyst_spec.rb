# frozen_string_literal: true

require './lib/sales_analyst'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/sales_engine'
require 'bigdecimal'

RSpec.describe SalesAnalyst do
  let(:data) do
    {
      items:         './data/items.csv', 
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoices.csv',
      transactions: './data/transactions.csv',
      customers:   './data/customers.csv'
    }
  end
  
  let(:engine) { SalesEngine.from_csv(data) }
  let(:analyst) { SalesAnalyst.new(engine) }
  describe '#initialize' do
    it 'exists' do
      expect(analyst).to be_a SalesAnalyst
    end
  end

  describe '#average_items_per_merchant' do
    it 'returns average # of items per merchant' do
      expect(analyst.average_items_per_merchant).to eq(2.88)
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'returns the strd dev for # of items per merchant' do
      expect(analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end
  end

  describe '#average_invoices_per_merchant' do
    it 'returns average # of invoices per merchant' do
      expect(analyst.average_invoices_per_merchant).to eq(10.49)
    end
  end

  describe '#average_invoices_per_merchant_standard_deviation' do
    it 'returns the std dev for # of invoices per merchant' do
      expect(analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'returns a list of merchants whose standard deviation of # of items is greater than 1' do
      expected = analyst.merchants_with_high_item_count
      expect(expected).to be_a Array
      expect(expected).to all(be_a Merchant)
      expected.each do |merchant|
        expect(merchant.item_count).to be > (
          analyst.average_items_per_merchant + analyst.average_items_per_merchant_standard_deviation
        )
      end
    end
  end
  
  describe '#average_item_price_for_merchant' do
    it "returns the average price of a merchant's items" do
      expect(analyst.average_item_price_for_merchant(12_334_105)).to eq 16.66
    end
  end

  describe '#average_average_price_per_merchant' do
    it 'returns an average of all merchant average item price' do
      expect(analyst.average_average_price_per_merchant).to eq 350.29
    end
  end

  describe '#golden_items' do
    it 'returns an array of item objects that are 2 std dev above average item price' do
      expected = analyst.golden_items
      expect(expected).to be_a Array
      expect(expected).to all(be_a Item)
      expected.each do |item|
        expect(item.unit_price).to be > (
          analyst.engine.items.average_price + analyst.engine.items.average_price_standard_deviation
        )
      end
    end
  end
end
