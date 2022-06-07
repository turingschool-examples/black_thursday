require "./lib/sales_engine"
require "./lib/sales_analyst"
require "./lib/merchant_repository"
require "./lib/invoice_repository"
require "./lib/item_repository"


RSpec.describe SalesAnalyst do
  let(:sales_engine) {SalesEngine.from_csv({
     :items     => "./data/items.csv",
     :merchants => "./data/merchants.csv",
     :invoices => "./data/invoices.csv",
     :invoice_items => "./data/invoice_items.csv",
     :transactions => "./data/transactions.csv",
     :customers => "./data/customers.csv"
     })}
  let(:sales_analyst) {sales_engine.analyst}
  it "exists" do
    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  it 'returns the average items per merchant' do
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it "count the total amount of items a merchant has" do
    expect(sales_analyst.count_merchants_items(12334105)).to eq(3)
  end

  it "finds all items a merchant has by ID and makes them into an array" do
    expect(sales_analyst.price_array(12334105)).to eq([29.99, 9.99, 9.99])
  end

  it "retrieves array of prices and number of items and calculates an average price for a merchant" do
    expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq(16.66)
  end

  it 'return a standard deviation of the number of items per merchant' do
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it 'checks for merchants with high item count' do
    expect(sales_analyst.merchants_with_high_item_count).to be_a(Array)
    expect(sales_analyst.merchants_with_high_item_count.length).to eq(52)
  end

  it 'return golden items' do
    expect(sales_analyst.golden_items).to be_a(Array)
    expect(sales_analyst.golden_items.length).to eq(5)
  end

  it 'can calculate standard_deviation'do
    expect(sales_analyst.standard_deviation([3,4,5],4)).to eq(1.0)
  end

  it "calculates the average average price per merchant (average of all merchants price)" do
    expect(sales_analyst.average_average_price_per_merchant).to eq(350.29)
  end

#Business intelligence tests start here
  it 'can calculate average_invoices_per_merchant' do
    expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
  end

  it 'can calculate average_invoices_per_merchant_standard_deviation' do
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
  end

  it 'can find top_merchants_by_invoice_count' do
    expect(sales_analyst.top_merchants_by_invoice_count.length).to eq(12)
  end

  it 'can find bottom_merchants_by_invoice_count' do
    expect(sales_analyst.bottom_merchants_by_invoice_count.length).to eq(4)
  end

  it 'can calculate the number of invoices per weekday' do
    expect(sales_analyst.invoices_per_weekday).to be_a(Hash)
    expect(sales_analyst.invoices_per_weekday.length).to eq(7)
    expect(sales_analyst.invoices_per_weekday.values[0]).to eq(696)
  end

  it 'can calculate the average invoices per weekday' do
    expect(sales_analyst.average_invoices_per_weekday).to be_a(Integer)
    expect(sales_analyst.average_invoices_per_weekday).to eq(712)
  end

  it 'can find top_days_by_invoice_count' do
    expect(sales_analyst.top_days_by_invoice_count.length).to eq(1)
    expect(sales_analyst.top_days_by_invoice_count.first).to eq("Wednesday")
  end

  it 'can calculate invoice status' do
    expect(sales_analyst.invoice_status(:pending)).to eq(29.55)
    expect(sales_analyst.invoice_status(:shipped)).to eq(56.95)
    expect(sales_analyst.invoice_status(:returned)).to eq(13.5)
  end

  it 'Indicates whether invoices have been paid' do
    expect(sales_analyst.invoice_paid_in_full?(1)).to be true
    expect(sales_analyst.invoice_paid_in_full?(200)).to be true
    expect(sales_analyst.invoice_paid_in_full?(203)).to be false
    expect(sales_analyst.invoice_paid_in_full?(204)).to be false
  end

  it 'Sums the total invoice cost' do
    expect(sales_analyst.invoice_total(1)).to eq(21067.77)
    expect(sales_analyst.invoice_total(1).class).to eq BigDecimal
  end

  it 'Finds the total revenue for a single merchant' do
    expect(sales_analyst.revenue_by_merchant(12334194)).to eq(97979.37)
    expect(sales_analyst.revenue_by_merchant(12334194)).to be_a(BigDecimal)
  end

  it "finds #merchants_with_pending_invoices returns merchants with pending invoices" do
    expected = sales_analyst.merchants_with_pending_invoices
    expect(expected.length).to eq 448
    expect(expected.first.class).to eq Merchant
  end

  it 'returns a merchants best item by revenue' do
    expect(sales_analyst.best_item_for_merchant(12334194).class).to eq(Item)
    expect(sales_analyst.best_item_for_merchant(12334112).id).to eq(263539438)
  end
end
