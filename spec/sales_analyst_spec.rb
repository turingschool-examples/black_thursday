require "./lib/sales_analyst"

RSpec.describe SalesAnalyst do
  before :each do
    @sales_engine = SalesEngine.from_csv({
    :items          => "./data/items.csv",
    :merchants      => "./data/merchants.csv",
    :invoices       => "./data/invoices.csv",
    :invoice_items  => "./data/invoice_items.csv",
    :transactions   => "./data/transactions.csv",
    :customers      => "./data/customers.csv"
    })
    @sales_analyst = @sales_engine.analyst
  end

  it 'exists' do
    expect(@sales_engine).to be_a(SalesEngine)
    expect(@sales_analyst).to be_a(SalesAnalyst)
  end

  it 'creates a hash of merchants and their number of items' do
    expect(@sales_analyst.merchant_items_hash.count).to eq(475)
  end

  it 'returns average items per merchant' do
    # require "pry"; binding.pry
    expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'returns average items per merchant standard deviation' do
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it 'returns the merchants that sell the most items' do
    expect(@sales_analyst.merchants_with_high_item_count).to include(Merchant)
    expect(@sales_analyst.merchants_with_high_item_count.count).to eq(52)
  end

  it 'returns the average item price for a given merchant' do
    expect(@sales_analyst.average_item_price_for_merchant(12334159)).to be_a(BigDecimal)
    expect(@sales_analyst.average_average_price_per_merchant).to be_a(BigDecimal)
  end

  it 'returns the average item price plus two standard deviations' do
    expect(@sales_analyst.average_price_plus_two_standard_deviations).to be_a(BigDecimal)
  end

  it 'returns the golden items' do
    expect(@sales_analyst.golden_items).to include(Item)
  end

  it 'returns the average invoices per merchant and standard deviation' do
    expect(@sales_analyst.average_invoices_per_merchant).to eq(10.49)
    expect(@sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
  end

  it 'returns a hash of merchants and their number of invoices' do
    expect(@sales_analyst.invoices_per_merchant.keys).to include(12334105)
  end

  it 'returns the top performing merchants' do
    expect(@sales_analyst.top_merchants_by_invoice_count).to include(Merchant)
  end

  it 'returns the lowest performing merchants' do
    expect(@sales_analyst.bottom_merchants_by_invoice_count).to include(Merchant)
  end

  it 'returns the invoice count for each day' do
    expect(@sales_analyst.invoice_count_by_day.count).to eq(7)
  end

  it 'returns the average invoices per day standard deviation' do
    expect(@sales_analyst.average_invoices_per_day_std_dev).to be_a(Float)
  end

  it 'returns the top days by invoice count' do
    expect(@sales_analyst.top_days_by_invoice_count).to be_a(Array)
  end

  it 'returns the percent of invoices that are shipped, pending, and returned' do
    expect(@sales_analyst.invoice_status(:pending)).to eq(29.55)
    expect(@sales_analyst.invoice_status(:shipped)).to eq(56.95)
    expect(@sales_analyst.invoice_status(:returned)).to eq(13.5)
  end

  it 'returns if invoice is paid in full' do
    expect(@sales_analyst.invoice_paid_in_full?(1752)).to eq(true)
  end

  it 'returns the total dollar amount of the invoice' do
    expect(@sales_analyst.invoice_total(4898)).to be_a(BigDecimal)
  end

  it 'finds the total revenue for a given date' do
    expect(@sales_analyst.total_revenue_by_date("2009-02-07")).to be_a(BigDecimal)
  end

  it 'has merchants with only one item' do
    expect(@sales_analyst.merchants_with_only_one_item).to be_a(Array)
    expect(@sales_analyst.merchants_with_only_one_item.length).to eq(243)
    expect(@sales_analyst.merchants_with_only_one_item.first).to be_a(Merchant)
  end

  it 'has merchants with only one item registered in month' do
    expect(@sales_analyst.merchants_with_only_one_item_registered_in_month("June").length).to eq(18)
    expect(@sales_analyst.merchants_with_only_one_item_registered_in_month("April").first).to be_a(Merchant)
  end

  it 'finds the total revenue for a single merchant' do
    expect(@sales_analyst.revenue_by_merchant(12334194)).to be_a(BigDecimal)
  end
end
