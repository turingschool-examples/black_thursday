# require 'spec_helper'
require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/item'
require './lib/merchant_repository'
require './lib/merchant'

RSpec.describe SalesAnalyst do
  let!(:sales_engine) {SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"})}

  let!(:sales_analyst) {sales_engine.analyst}

  it 'exists' do
    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  it 'has an average number of items per merchant' do
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
    expect(sales_analyst.average_items_per_merchant).to be_a(Float)
  end

  it 'has a total number of items' do
    expect(sales_analyst.items_count).to eq(1367)
  end
  
  it 'has a total number of merchants' do
    expect(sales_analyst.merchants_count).to eq(475)
  end

  it 'can return the standard deviation of average number of items per merchant' do
    require 'pry'; binding.pry
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to be_a(Float)
  end

  xit 'can return the merchant with the highest item count (most items sold)' do 
    expect(sales_analyst.merchants_with_high_item_count.length).to eq(52)
    expect(sales_analyst.merchants_with_high_item_count.first.class).to eq(Merchant)
  end

  xit 'can return average item price for the given merchant' do
    expect(sales_analyst.average_item_price_for_specific_merchant(12334105)).to eq(16.66)
    expect(sales_analyst.average_item_price_for_specific_merchant(12334105).class).to eq(BigDecimal)
  end

  xit 'can return average item price per (all) merchants' do
    expect(sales_analyst.average_item_price_for_all_merchants).to eq(350.29)
    expect(sales_analyst.average_item_price_for_all_merchants).to eq(BigDecimal)
  end

  xit 'can return items that are two standard deviations ABOVE the average ITEM price (golden items)' do
    expect(sales_analyst.golden_items.length).to eq(5)
    expect(sales_analyst.golden_items.first.class).to eq(Item)
  end

  # ======================================= #
  
  xit 'has an average number of invoices per merchant' do
    expect(sales_analyst.average_invoices_per_merchant).to eq(x.xx)
    expect(sales_analyst.average_invoices_per_merchant).to eq(Float)
  end

  xit 'can return the standard deviation of average number of invoices per merchant' do
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(x.xx)
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(Float)
  end

  xit 'can return the merchant with the highest invoice count' do
    expect(sales_analyst.top_merchants_by_invoice_count.length).to eq(xx)
    expect(sales_analyst.top_merchants_by_invoice_count.first.class).to eq(Merchant)
  end

  xit 'can return the merchant with the lowest invoice count' do
    expect(sales_analyst.bottom_merchants_by_invoice_count.length).to eq(x)
    expect(sales_analyst.bottom_merchants_by_invoice_count.first.class).to eq(Merchant)
  end

  xit 'can return the days with the highest invoice count' do
    expect(sales_analyst.top_days_by_invoice_count.length).to eq(x)
    expect(sales_analyst.top_days_by_invoice_count.first).to eq("xxDay")
    expect(sales_analyst.top_days_by_invoice_count.first.class).to eq(String)
  end

  xit 'can return percentage of invoices that are not shipped' do
    sales_analyst.invoice_status(:pending)
    expect(sales_analyst.invoice_status(:status)).to eq(xx.xx)

    sales_analyst.invoice_status(:pending)
    expect(sales_analyst.invoice_status(:shipped)).to eq(xx.xx)

    sales_analyst.invoice_status(:pending)
    expect(sales_analyst.invoice_status(:returned)).to eq(xx.xx)
   
    expect(sales_analyst.invoice).to eq(xx.x)
  end

end
