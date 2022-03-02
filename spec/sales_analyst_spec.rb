require 'rspec'
require './lib/sales_engine.rb'
require './lib/sales_analyst.rb'

RSpec.describe SalesAnalyst do

  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices     => "./data/invoices.csv",
      :invoice_items     => "./data/invoice_items.csv",
      :customers     => "./data/customers.csv",
      :transactions     => "./data/transactions.csv",
      :merchants => "./data/merchants.csv"})
  end

  it 'average items per merchant' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'sales ' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end


  it 'merchants with high item counts' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.merchants_with_high_item_count.length).to eq(52)
  end

  it 'can see the average price of items for a given merchant' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.average_item_price_for_merchant("12334105")).to eq(16.66)
    expect(sales_analyst.average_item_price_for_merchant("12334105").class).to eq(BigDecimal)
  end


  it "average item price per merchant" do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.average_average_price_per_merchant).to eq(350.29)
    expect(sales_analyst.average_average_price_per_merchant.class).to eq(BigDecimal)
  end

  it "golden items" do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.golden_items.length).to eq(5)
  end

  it 'average_invoices_per_merchant' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
  end

  it 'average invoices per merchant standard deviation' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
  end

  it 'top merchants by invoice count' do
    sales_analyst = @sales_engine.analyst
    expected = sales_analyst.top_merchants_by_invoice_count

    expect(expected.length).to eq 12
    expect(expected.first.class).to eq Merchant
  end

  it 'bottom merchants by invoice count' do
    sales_analyst = @sales_engine.analyst
    expected = sales_analyst.bottom_merchants_by_invoice_count

    expect(expected.length).to eq 4
    expect(expected.first.class).to eq Merchant
  end

  it 'top days by invoice count' do
    sales_analyst = @sales_engine.analyst

    expect(sales_analyst.top_days_by_invoice_count).to eq(["Wednesday"])
  end

  it 'invoice status' do
    sales_analyst = @sales_engine.analyst
    expect(sales_analyst.invoice_status(:pending)).to eq(29.55)
    expect(sales_analyst.invoice_status(:shipped)).to eq(56.95)
    expect(sales_analyst.invoice_status(:returned)).to eq(13.5)
  end
end
