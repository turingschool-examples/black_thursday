# frozen_string_literal: true

require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/items'
require './lib/merchants'

RSpec.describe SalesAnalyst do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                     items: './data/items.csv',
                                     merchants: './data/merchants.csv',
                                     invoices: "./data/invoices.csv"
                                   })
    @sales_analyst = @engine.analyst
  end

  it 'exists' do
    expect(@sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it '#average_items_per_merchant returns average items per merchant' do
    expected = @sales_analyst.average_items_per_merchant

    expect(expected).to eq 2.88
    expect(expected.class).to eq Float
  end

  it '#average_items_per_merchant_standard_deviation returns the standard deviation' do
    expected = @sales_analyst.average_items_per_merchant_standard_deviation

    expect(expected).to eq 3.26
    expect(expected.class).to eq Float
  end

  it '#average_item_price_for_merchant returns the average item price for the given merchant' do
    merchant_id = 12_334_105
    expected = @sales_analyst.average_item_price_for_merchant(merchant_id)

    expect(expected).to eq 16.66
    expect(expected.class).to eq BigDecimal
  end

  it '#average_average_price_per_merchant returns the average price for all merchants' do
    expected = @sales_analyst.average_average_price_per_merchant

    expect(expected).to eq 350.29
    expect(expected.class).to eq BigDecimal
  end

  it '#golden_items returns items that are two standard deviations above the average price' do
    expected = @sales_analyst.golden_items

    expect(expected.length).to eq 5
    expect(expected.first.class).to eq Item
  end

  it '#average_invoices_per_merchant' do
    expected = @sales_analyst.average_invoices_per_merchant
    expect(expected).to eq 10.49
    expect(expected.class).to eq Float
  end

  it "#average_invoices_per_merchant_standard_deviation" do
    expected = @sales_analyst.average_invoices_per_merchant_standard_deviation

    expect(expected).to eq 3.29
    expect(expected.class).to eq Float
  end

  it "#top_merchants_by_invoice_count returns merchants that are two standard deviations above the mean" do
    expected = @sales_analyst.top_merchants_by_invoice_count

    expect(expected.length).to eq 12
    expect(expected.first.class).to eq Merchant
  end

  it "#bottom_merchants_by_invoice_count returns merchants that are two standard deviations below the mean" do
    expected = @sales_analyst.bottom_merchants_by_invoice_count

    expect(expected.length).to eq 4
    expect(expected.first.class).to eq Merchant
  end

  it "#top_days_by_invoice_count" do
    expected = @sales_analyst.top_days_by_invoice_count

    expect(expected.length).to eq 1
    expect(expected.first).to eq "Wednesday"
    expect(expected.first.class).to eq String
  end

  it "#invoice_status returns the percentage of invoices with given status" do
    expected = @sales_analyst.invoice_status(:pending)
    expect(expected).to eq 29.55
    expected = @sales_analyst.invoice_status(:shipped)
    expect(expected).to eq 56.95
    expected = @sales_analyst.invoice_status(:returned)
    expect(expected).to eq 13.5
  end
end
