# require 'spec_helper'
require 'csv'
require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/item'
require './lib/item_repository'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/invoice'
require './lib/invoice_repository'
require './lib/invoice_item'
require './lib/invoice_item_repository'
require './lib/customer'
require './lib/customer_repository'
require './lib/transaction'
require './lib/transaction_repository'

RSpec.describe SalesAnalyst do
  let!(:sales_engine) {SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :customers => "./data/customers.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"
    })}

  let!(:sales_analyst) {sales_engine.analyst}

  xit 'exists' do
    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  xit 'has an average number of items per merchant' do
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
    expect(sales_analyst.average_items_per_merchant).to be_a(Float)
  end

  xit 'has a total number of items' do
    expect(sales_analyst.items_count).to eq(1367)
  end
  
  xit 'has a total number of merchants' do
    expect(sales_analyst.merchants_count).to eq(475)
  end

  xit 'can return the standard deviation of average number of items per merchant' do
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to be_a(Float)
  end

  xit 'can return the merchants with the high item counts' do 
    expect(sales_analyst.merchants_with_high_item_count.length).to eq(52)
    expect(sales_analyst.merchants_with_high_item_count.first.class).to eq(Merchant)
  end

  xit 'can return average item price for the given merchant' do
    expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq(16.66)
    expect(sales_analyst.average_item_price_for_merchant(12334105).class).to eq(BigDecimal)
  end

  xit 'can return average item price per (all) merchants' do
    expect(sales_analyst.average_average_price_per_merchant).to eq(350.29)
    expect(sales_analyst.average_average_price_per_merchant.class).to eq(BigDecimal)
  end
  
  xit 'can return an average price for all items' do
    expect(sales_analyst.average_price_for_all_items).to eq(25105.51)
    expect(sales_analyst.average_price_for_all_items.class).to eq(Float)
  end
  
  xit 'can return a standard deviation for all items' do
    expect(sales_analyst.average_standard_deviation_for_all_items).to eq(290099.0)
    expect(sales_analyst.average_standard_deviation_for_all_items.class).to eq(Float)
  end

  xit 'can return items that are two standard deviations ABOVE the average ITEM price (golden items)' do
    expect(sales_analyst.golden_items.length).to eq(5)
    expect(sales_analyst.golden_items.first.class).to eq(Item)
  end

  # ======================================= #

  xit 'has an average number of invoices per merchant' do
    expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
    expect(sales_analyst.average_invoices_per_merchant.class).to eq(Float)
  end

  xit 'has a total number of invoices' do
    expect(sales_analyst.invoice_count).to eq(4985)
  end
  
  xit 'can return the standard deviation of average number of invoices per merchant' do
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation.class).to eq(Float)
  end
  
  xit 'can return the merchant with the highest invoice count' do
    expect(sales_analyst.top_merchants_by_invoice_count.length).to eq(12)
    expect(sales_analyst.top_merchants_by_invoice_count.first.class).to eq(Merchant)
  end
  
  xit 'can return the merchant with the lowest invoice count' do
    expect(sales_analyst.bottom_merchants_by_invoice_count.length).to eq(4)
    expect(sales_analyst.bottom_merchants_by_invoice_count.first.class).to eq(Merchant)
  end
  
  it 'can return the days with the highest invoice count' do
    expect(sales_analyst.top_days_by_invoice_count.length).to eq(1)
    expect(sales_analyst.top_days_by_invoice_count.first).to eq("Wednesday")
    expect(sales_analyst.top_days_by_invoice_count.first.class).to eq(String)
  end
  
  xit 'can return percentage of invoices that are not shipped' do
    expect(sales_analyst.invoice_status(:pending)).to eq(29.55)
    expect(sales_analyst.invoice_status(:shipped)).to eq(56.95)
    expect(sales_analyst.invoice_status(:returned)).to eq(13.5)
  end

  # ======================================= #

  xit 'can return true if the invoice with corresponding id is paid in full' do
    sales_analyst.invoice_paid_in_full?(1)
      expect(expected.sales_analyst.invoice_paid_in_full?(1)).to eq(true)

      sales_analyst.invoice_paid_in_full?(200)
      expect(expected.sales_analyst.invoice_paid_in_full?(200)).to eq(true)

      sales_analyst.invoice_paid_in_full?(203)
      expect(sales_analyst.invoice_paid_in_full?(203)).to eq(false)

      sales_analyst.invoice_paid_in_full?(204)
      expect(sales_analyst.invoice_paid_in_full?(204)).to eq(false)
  end

  xit 'can return the total dollar amount if the invoice is paid in full ' do
    sales_analyst.invoice_total(1)

    expect(sales_analyst.invoice_total(1)).to eq(21067.77)
    expect(sales_analyst.invoice_total(1).class).to eq(BigDecimal)
  end
end
