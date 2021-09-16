require 'rspec'
require './lib/sales_engine'
require './lib/item'
require './lib/item_repository'
require './lib/sales_analyst'
require './lib/merchant.rb'
require './lib/merchant_repository.rb'


RSpec.describe SalesAnalyst do
  let(:se) { SalesEngine.from_csv({
      items:          './data/items.csv',
      merchants:      './data/merchants.csv',
      invoices:       './data/invoices.csv',
      invoice_items:  './data/invoice_items.csv',
      transactions:   './data/transactions.csv',
      customers:      './data/customers.csv'
    }) }
    
  let(:analyst) { se.analyst }

  context 'Iteration 1' do
    it 'exists' do
      expect(analyst).to be_a SalesAnalyst
    end

    it '#average_items_per_merchant' do
      expect(analyst.average_items_per_merchant).to eq 2.88
    end

    it '#average_items_per_merchant_standard_deviation' do
      expect(analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end


    it '#merchants_with_high_item_count' do #need better test
      expect(analyst.merchants_with_high_item_count).to be_an Array
    end

    it '#average_item_price_for_merchant' do
      expect(analyst.average_item_price_for_merchant(12334159)).to eq 0.315e2
    end

    it '#average_average_price_per_merchant' do #better test? 'big decimal?'
      expect(analyst.average_average_price_per_merchant).to be_a BigDecimal
    end

    it '#average_price_standard_deviation' do
      expect(analyst.average_price_standard_deviation).to be_a Float
      expect(analyst.average_price_standard_deviation).not_to eq 0.0
    end

    it '#golden_item' do # better test
      expect(analyst.golden_items).to be_an Array
    end
  end

  context 'Iteration 2' do
  end
end
