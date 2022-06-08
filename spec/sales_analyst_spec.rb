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
  it "exists" do
    expect(@sales_analyst).to be_a SalesAnalyst
  end

  it "shows average items per merchant" do
    expect(@sales_analyst.average_items_per_merchant.class).to eq Float
    expect(@sales_analyst.average_items_per_merchant).to eq 2.88
  end

  it "can check that invoice is paid in full" do
    expect(@sales_analyst.invoice_paid_in_full?(2179)).to eq true
  end

  it "can check if invoice is not paid in full" do
    expect(@sales_analyst.invoice_paid_in_full?(1752)).to eq false
  end

  it "returns the total #$ amount of the invoice with matching id" do
    expect(@sales_analyst.invoice_total(1)).to eq 21067.77
  end

  it "calculates average_item_price_for_merchant" do
    expect(@sales_analyst.average_item_price_for_merchant(12334105)).to be_a Float
    expect(@sales_analyst.average_item_price_for_merchant(12334105)).to eq 16.66
  end

  it "calculates items per merchant standard dev" do
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to be_a Float
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq 3.26
  end
  it "sorts merchants_with_high_item_count" do
    expect(@sales_analyst.merchants_with_high_item_count).to be_a Array
    expect(@sales_analyst.merchants_with_high_item_count.count).to eq(52)
    expect(@sales_analyst.merchants_with_high_item_count.first).to be_a Merchant
    expect(@sales_analyst.merchants_with_high_item_count.first.id).to eq(12334195)
  end

  it "can sum all of the averages and find the average price across all merchants" do
    expect(@sales_analyst.average_average_price_per_merchant).to be_a Float
    expect(@sales_analyst.average_average_price_per_merchant).to eq(350.29)
  end

  it "can calculate standard_deviation of item_price" do
    expect(@sales_analyst.price_std_dev).to eq(290099.0)
  end

  it "can return items 2 standard deviations above average" do
    expect(@sales_analyst.golden_items).to be_a Array
    expect(@sales_analyst.golden_items.first.class).to eq Item
    expect(@sales_analyst.golden_items.length).to eq 5
  end

  it "can calculate average invoices per merchant" do
    expect(@sales_analyst.average_invoices_per_merchant).to eq(10.49)
  end

  it "can calculate average_invoices_per_merchant_standard_deviation" do
    expect(@sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
  end


  it "can calculate top_merchants_by_invoice_count" do
    expect(@sales_analyst.top_merchants_by_invoice_count.length).to eq(12)
    expect(@sales_analyst.top_merchants_by_invoice_count.first.class).to eq Merchant
  end

  it "can calculate bottom_merchants_by_invoice_count" do
    expect(@sales_analyst.bottom_merchants_by_invoice_count.length).to eq(4)
    expect(@sales_analyst.bottom_merchants_by_invoice_count.first.class).to eq Merchant
  end

end
