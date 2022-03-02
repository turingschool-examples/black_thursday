# frozen_string_literal: true

require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require 'pry'
require 'bigdecimal'

RSpec.describe SalesAnalyst do
  before(:each) do
    @se = SalesEngine.from_csv({
                                 items: './data/items.csv',
                                 merchants: './data/merchants.csv',
                                 invoices: './data/invoices.csv',
                                 invoice_items: './data/invoice_items.csv',
                                 transactions: './data/transactions.csv',
                                 customers: './data/customers.csv'
                               })
    @sa = @se.analyst
  end

  it '#average_items_per_merchant returns average items per merchant' do
    expected = @sa.average_items_per_merchant

    expect(expected).to eq 2.88
    expect(expected.class).to eq Float
  end

  it '#average_items_per_merchant_standard_deviation returns the standard deviation' do
    expected = @sa.average_items_per_merchant_standard_deviation

    expect(expected).to eq 3.26
    expect(expected.class).to eq Float
  end

  it 'returns #merchants_with_high_item_count' do
    expected = @sa.merchants_with_high_item_count

    expect(expected.length).to eq 52
    expect(expected.first.class).to eq Merchant
  end

  it '#average_item_price_for_merchant returns the average item price for the given merchant' do
    merchant_id = 12_334_132
    expected = @sa.average_item_price_for_merchant(merchant_id)

    expect(expected).to eq 35.00
    expect(expected.class).to eq BigDecimal
  end

  it '#average_average_price_per_merchant returns the average price for all merchants' do
    expected = @sa.average_average_price_per_merchant

    expect(expected).to eq 350.29
    expect(expected.class).to eq BigDecimal
  end

  it '#golden_items returns items that are two standard deviations above the average price' do
    expected = @sa.golden_items

    expect(expected.length).to eq 5
    expect(expected.first.class).to eq Item
  end

  it '#average_invoices_per_merchant returns average number of invoices per merchant' do
    # require "pry"; binding.pry
    expected = @sa.average_invoices_per_merchant
    expect(expected).to eq 10.49
    expect(expected.class).to eq Float
  end

  it '#average_invoices_per_merchant_standard_deviation returns the standard deviation' do
    expected = @sa.average_invoices_per_merchant_standard_deviation

    expect(expected).to eq 3.29
    expect(expected.class).to eq Float
  end

  it '#top_merchants_by_invoice_count returns merchants that are two standard deviations above the mean' do
    expected = @sa.top_merchants_by_invoice_count

    expect(expected.length).to eq 12
    expect(expected.first.class).to eq Merchant
  end

  it '#bottom_merchants_by_invoice_count returns merchants that are two standard deviations below the mean' do
    expected = @sa.bottom_merchants_by_invoice_count

    expect(expected.length).to eq 4
    expect(expected.first.class).to eq Merchant
  end

  it '#top_days_by_invoice_count returns days with an invoice count more than one standard deviation above the mean' do
    expected = @sa.top_days_by_invoice_count

    expect(expected.length).to eq 1
    expect(expected.first).to eq 'Wednesday'
    expect(expected.first.class).to eq String
  end

  it '#invoice_status returns the percentage of invoices with given status' do
    expected = @sa.invoice_status(:pending)

    expect(expected).to eq 29.55

    expected = @sa.invoice_status(:shipped)

    expect(expected).to eq 56.95

    expected = @sa.invoice_status(:returned)

    expect(expected).to eq 13.5
  end

  context 'Business Intelligence' do
    it '#is_paid_in_full? returns true if the invoice is paid in full' do
      expected = @sa.invoice_paid_in_full?(1)
      expect(expected).to eq true

      expected = @sa.invoice_paid_in_full?(200)
      expect(expected).to eq true

      expected = @sa.invoice_paid_in_full?(203)
      expect(expected).to eq false

      expected = @sa.invoice_paid_in_full?(204)
      expect(expected).to eq false
    end

    it 'SalesAnalyst#total returns the total dollar amount if the invoice is paid in full' do
      expected = @sa.invoice_total(1)
      expect(expected).to eq 21_067.77
      expect(expected.class).to eq BigDecimal
    end

    it '#total returns the total dollar amount if the invoice is paid in full' do
      expected = @sa.invoice_total(1)

      expect(expected).to eq 21_067.77
      expect(expected.class).to eq BigDecimal
    end

    it '#total_revenue_by_date returns total revenue for given date' do
      date = Time.parse('2009-02-07')
      expected = @sa.total_revenue_by_date(date)

      expect(expected).to eq 21_067.77
      expect(expected.class).to eq BigDecimal
    end
  end
end
