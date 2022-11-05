# frozen_string_literal: true

require './lib/sales_analyst'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/sales_engine'
require 'bigdecimal'

RSpec.describe SalesAnalyst do
  let(:data) { {
      items:         './data/items.csv', 
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoices.csv',
      transactions: './data/transactions.csv',
      customers:   './data/customers.csv',
      } }
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
    it 'returns a list of merchants whose standard deviation of # of items is 1 or greater' do

    end
  end

  describe '#average_item_price_for_merchant' do
    it "returns the average price of a merchant's items" do
      expect(analyst.average_item_price_for_merchant(12334105)).to eq 16.66
    end
  end

  # describe '#average_average_price_per_merchant' do
  #   it 'returns an average of all merchant average item price' do
  #     item_repo = double('ItemRepo')
  #     allow(item_repo).to receive(:find_all_by_merchant_id).and_return([2, 5, 3, 9])
  #     expect(sa.average_item_price_for_merchant(item_repo, 22222)).to eq 
  #   end
  # end

  describe '#golden_items' do
    it '' do

    end
  end
end
