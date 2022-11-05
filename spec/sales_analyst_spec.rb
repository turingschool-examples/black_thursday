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

  describe '#golden_items' do
    it 'returns an array of item objects that are 2 std dev above average item price' do
      expected = analyst.golden_items
      expect(expected).to be_a Array
      expect(expected).to all(be_a Merchant)
      expected.each do |item|
        expect(item.unit_price).to be > (
          analyst.average_price + analyst.average_price_standard_deviation
        )
      end
    end
  end
end
