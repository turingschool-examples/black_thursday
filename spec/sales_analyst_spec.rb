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
      expected = analyst.average_items_per_merchant

      expect(expected).to eq 2.88
      expect(expected).to be_a Float
    end

    it '#average_items_per_merchant_standard_deviation' do
      expected = analyst.average_items_per_merchant_standard_deviation

      expect(expected).to eq(3.26)
      expect(expected).to be_a Float
    end

    it '#merchants_with_high_item_count' do
      expected = analyst.merchants_with_high_item_count

      expect(expected.length).to eq 52
      expect(expected).to be_an Array
      expect(expected.first).to be_a Merchant
    end

    it '#average_item_price_for_merchant' do
      merchant_id = 12334159
      expected = analyst.average_item_price_for_merchant(merchant_id)

      expect(expected).to eq 0.315e2
      expect(expected).to be_a BigDecimal
    end

    it '#average_average_price_per_merchant' do
      expected = analyst.average_average_price_per_merchant

      expect(expected).to eq 350.29
      expect(expected).to be_a BigDecimal
    end

    it '#average_price_standard_deviation' do
      expected = analyst.average_price_standard_deviation

      expect(expected).to be_a Float
      expect(analyst.average_price_standard_deviation).to eq 2902.69
    end

    it '#golden_item' do
      expected = analyst.golden_items

      expect(expected).to be_an Array
      expect(expected.length).to eq 5
    end
  end

  context 'Iteration 2' do
    it '#average_invoices_per_merchant' do
      expected = analyst.average_invoices_per_merchant

      expect(expected).to eq 10.49
      expect(expected).to be_a Float
    end

    it '#average_invoices_per_merchant_standard_deviation' do
      expected = analyst.average_invoices_per_merchant_standard_deviation

      expect(expected).to eq 3.29
      expect(expected).to be_a Float
    end

    it '#top_merchants_by_invoice_count' do
      expected = analyst.top_merchants_by_invoice_count

      expect(expected).to be_an Array
      expect(expected.length).to eq 12
      expect(expected.first).to be_a Merchant
    end

    it '#bottom_merchants_by_invoice_count' do
      expected = analyst.bottom_merchants_by_invoice_count

      expect(expected).to be_an Array
      expect(expected.length).to eq 4
      expect(expected.first).to be_a Merchant
    end

    it '#invoices_by_day' do
      expected = analyst.invoices_by_day

      expect(expected).to be_a Hash
      expect(expected.keys.length).to eq 7
    end

    it '#invoices_by_day_mean' do
      expected = analyst.invoices_by_day_mean

      expect(expected).to be_a Float
      expect(expected).to eq 712.14
    end

    it '#invoices_by_day_standard_deviation' do
      expected = analyst.invoices_by_day_standard_deviation

      expect(expected).to be_a Float
      expect(expected).to eq 18.07
    end

    it '#top_days_by_invoice_count' do
      expected = analyst.top_days_by_invoice_count

      expect(expected).to be_an Array
      expect(expected.length).to eq 1
      expect(expected.first).to eq 'Wednesday'
      expect(expected.first).to be_a String
    end

    it '#invoice_status' do
      expect(analyst.invoice_status(:pending)).to eq 29.55
      expect(analyst.invoice_status(:shipped)).to eq 56.95
      expect(analyst.invoice_status(:returned)).to eq 13.5
    end
  end
end
