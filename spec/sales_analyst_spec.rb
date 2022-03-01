require './lib/sales_analyst'
require 'rspec'
require 'bigdecimal'

describe Analyst do
  before (:each) do
    @sales_analyst = Analyst.new
  end

  it "finds average" do
    expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it "finds standard_devation" do
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it "finds merchants_with_high_item_count" do
    expect(@sales_analyst.merchants_with_high_item_count.count).to eq(52)
  end

  it "finds average item price per merchant" do
    expect(@sales_analyst.average_item_price_per_merchant("12334185")).to eq(10.78)
    expect(@sales_analyst.average_item_price_per_merchant("12334185")).to be_a(BigDecimal)
  end

  it "finds average_average_price_per_merchant" do
    expect(@sales_analyst.average_average_price_per_merchant).to eq(350.29)
    expect(@sales_analyst.average_average_price_per_merchant).to be_a(BigDecimal)
  end

  it "finds the golden items" do
    expect(@sales_analyst.golden_items.count).to eq(5)
  end

  it "finds the average_invoices_per_merchant" do
    expect(@sales_analyst.average_invoices_per_merchant).to eq(10.49)
  end

  it "finds the average invoices per merchant standard_devation" do
    expect(@sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
  end

  it "find merchants with high invoice count" do
    expect(@sales_analyst.top_merchants_by_invoice_count.count).to eq(12)
  end

  it "finds merchants with low invoice count" do
    expect(@sales_analyst.bottom_merchants_by_invoice_count.count).to eq(4)
  end

  it "can tell the day of the week" do
    expect(@sales_analyst.top_days_by_invoice_count).to eq(["Wednesday"])
  end

  it "can find invoices by status and returns a percent" do
    expect(@sales_analyst.invoice_status(:pending)).to eq(29.55)
    expect(@sales_analyst.invoice_status(:shipped)).to eq(56.95)
    expect(@sales_analyst.invoice_status(:returned)).to eq(13.5)
  end

  it "can find the total revenue for the day" do
    expect(@sales_analyst.total_revenue_by_date(date)).to eq(456)
  end
end
