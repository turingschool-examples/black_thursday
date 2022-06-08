require './lib/merchant_repository'
require './lib/merchant'
require './lib/item_repository'
require './lib/item'
require './lib/sales_engine'
require './lib/sales_analyst'
require './lib/invoice_repository'
require './lib/invoice'
require './lib/invoice_item_repository'
require './lib/transaction_repository'
require './lib/customer_repository'

RSpec.describe SalesAnalyst do
  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
    @sales_analyst = @sales_engine.analyst
  end
  xit "exists" do
    expect(@sales_analyst).to be_a SalesAnalyst
  end

  xit "shows average items per merchant" do
    expect(@sales_analyst.average_items_per_merchant.class).to eq Float
    expect(@sales_analyst.average_items_per_merchant).to eq 2.88
  end

  xit "can check that invoice is paid in full" do
    expect(@sales_analyst.invoice_paid_in_full?(2179)).to eq true
  end

  xit "can check if invoice is not paid in full" do
    expect(@sales_analyst.invoice_paid_in_full?(1752)).to eq false
  end

  xit "returns the total #$ amount of the invoice with matching id" do
    expect(@sales_analyst.invoice_total(1)).to eq 21067.77
  end

  xit "calculates average_item_price_for_merchant" do
    expect(@sales_analyst.average_item_price_for_merchant(12334105)).to be_a Float
    expect(@sales_analyst.average_item_price_for_merchant(12334105)).to eq 16.66
  end

  xit "calculates items per merchant standard dev" do
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to be_a Float
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq 3.26
  end
  xit "sorts merchants_with_high_item_count" do
    expect(@sales_analyst.merchants_with_high_item_count).to be_a Array
    expect(@sales_analyst.merchants_with_high_item_count.count).to eq(52)
    expect(@sales_analyst.merchants_with_high_item_count.first).to be_a Merchant
    expect(@sales_analyst.merchants_with_high_item_count.first.id).to eq(12334195)
  end

  xit "can sum all of the averages and find the average price across all merchants" do
    expect(@sales_analyst.average_average_price_per_merchant).to be_a Float
    expect(@sales_analyst.average_average_price_per_merchant).to eq(350.29)
  end

  xit "can calculate standard_deviation of item_price" do
    expect(@sales_analyst.price_std_dev).to eq(290099.0)
  end

  xit "can return items 2 standard deviations above average" do
    expect(@sales_analyst.golden_items).to be_a Array
    expect(@sales_analyst.golden_items.first.class).to eq Item
    expect(@sales_analyst.golden_items.length).to eq 5
  end

  xit "can calculate average invoices per merchant" do
    expect(@sales_analyst.average_invoices_per_merchant).to eq(10.49)
  end

  xit "can calculate average_invoices_per_merchant_standard_deviation" do
    expect(@sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
  end

  xit "can calculate top_merchants_by_invoice_count" do
    expect(@sales_analyst.top_merchants_by_invoice_count.length).to eq(12)
    expect(@sales_analyst.top_merchants_by_invoice_count.first.class).to eq Merchant
  end

  xit "can calculate bottom_merchants_by_invoice_count" do
    expect(@sales_analyst.bottom_merchants_by_invoice_count.length).to eq(4)
    expect(@sales_analyst.bottom_merchants_by_invoice_count.first.class).to eq Merchant
  end

  xit "calculates percentage of invoices that are shipped/ pending/returned? (takes symbol as argument)" do
    expect(@sales_analyst.invoice_status(:pending)).to eq(29.55)
    expect(@sales_analyst.invoice_status(:shipped)).to eq(56.95)
    expect(@sales_analyst.invoice_status(:returned)).to eq(13.5)
  end

  it "gets days of week array" do
    expect(@sales_analyst.date_to_day).to be_a(Array)
  end

  it "date to day: gets all the instances of an invoice in its array" do
    expect(@sales_analyst.date_to_day.count).to eq(4985)
  end

  it "shows which days are invoices created at more than one standard deviation above the mean" do
    expect(@sales_analyst.top_days_by_invoice_count).to eq(["Wednesday"])
  end

  # it "gets seperate days" do
  #   expect(@sales_analyst.seperate_days).to be_a(Array)
  # end
end
