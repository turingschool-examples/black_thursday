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

  context 'Iteration 3' do

    it '#invoice_paid_in_full?' do
      expected1 = analyst.invoice_paid_in_full?(4702)
      expected2 = analyst.invoice_paid_in_full?(1389)
      expect(expected1).to be true
      expect(expected2).to be false
    end

    it '#invoice_total' do
      invoice_total1 = (analyst.invoice_total(2)).to_f
      expect(invoice_total1).to eq(5289.13)

      invoice_total2 = (analyst.invoice_total(1389)).to_f
      expect(invoice_total2).to eq(0)

      invoice_total3 = (analyst.invoice_total(4702)).to_f
      expect(invoice_total3).to eq(5010.21)
    end
  end

  context 'Iteration 4' do

    it '#find_all_invoice_item_by_date' do
      expect(analyst.find_all_invoice_item_by_date('2014-02-13')).to be_a(Array)
      expect(analyst.find_all_invoice_item_by_date('2014-02-13').length).to eq(1)
    end

    it '#total_revenue_by_date' do
      expect(analyst.total_revenue_by_date('2014-02-13')).to eq(0)
      expect(analyst.total_revenue_by_date('2009-02-24')).to eq(1363.50)
    end

    it '#top_revenue_earners' do
      expected = analyst.top_revenue_earners(5)
      first = expected.first
      last = expected.last

      expect(expected.length).to eq 5

      expect(first.class).to eq Merchant
      expect(first.id).to eq 12334634

      expect(last.class).to eq Merchant
      expect(last.id).to eq 12335747
    end

    it '#merchants_with_pending_invoices' do
      expected = analyst.merchants_with_pending_invoices

      expect(expected).to be_an Array
      expect(expected.length).to eq 467
      require "pry"; binding.pry
    end

    it '#merchants_with_only_one_item' do
      expected = analyst.merchants_with_only_one_item

      expect(expected).to be_an Array
      expect(expected.length).to eq 243
    end

    it '#merchants_with_only_one_item_registered_in_month' do
      expected1 = analyst.merchants_with_only_one_item_registered_in_month('March')
      expected2 = analyst.merchants_with_only_one_item_registered_in_month('June')

      expect(expected1).to be_an Array
      expect(expected1.length).to eq 21
      expect(expected2.length).to eq 18
    end
  end
end
