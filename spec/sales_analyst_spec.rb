# frozen_string_literal: true

require './lib/sales_analyst'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/sales_engine'
require 'bigdecimal'
require './lib/invoice_item_repository'

RSpec.describe SalesAnalyst do
  let(:data) do
    {
      items:         './data/items.csv', 
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
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

  describe '#invoice_status' do
    it 'returns an percent value for invoice objects that match the type symbol passed' do
      expected = analyst.invoice_status(:shipped)
      expect(expected).to be_a Float
      expect(0..100).to include(expected)
    end
  end

  describe '#top_days_by_invoice_count' do
    it 'returns a collection of all days that are above the average by one std deviation' do
      expected = analyst.top_days_by_invoice_count
      expect(expected).to be_a Array
      expected.each do |day|
        expect(day).to be('Wednesday')
      end
    end
  end

  describe '#invoice_paid_in_full?' do
    it 'returns a boolean indicating whether or not an invoice has been paid' do
      expect(analyst.invoice_paid_in_full?(46)).to be true
      expect(analyst.invoice_paid_in_full?(204)).to be false
    end
  end

  describe '#invoice_total' do
    it 'returns the total dollar value of an Invoice' do
      expect(analyst.invoice_total(1)).to eq 21067.77
    end
  end

  describe '#total_revenue_by_date' do
    it 'sums the total of each invoice paid on a certain date' do
      expect(analyst.total_revenue_by_date('2009-02-07')).to eq 21067.77
    end
  end

  describe '#top_revenue_earners' do
    it 'returns an array of x merchants ranked by revenue' do
      expected = analyst.top_revenue_earners(10)

      expect(expected.length).to eq 10
      expect(expected.first.class).to eq Merchant
      expect(expected.first.id).to eq 12334634
      expect(expected.last.class).to eq Merchant
      expect(expected.last.id).to eq 12335747
    end
  end
end
