require_relative "../lib/sales_analyst"
require_relative "../lib/sales_engine"
require 'rspec'

describe SalesAnalyst do
  before :each do
    @se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      customers: './data/customers.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
    })
    @sa = @se.analyst
  end

  xit '#average_item_per_merchant' do

    expect(@sa.average_items_per_merchant).to eq(2.88)
  end

  xit '#average_item_per_merchant_standard_deviation' do

    expect(@sa.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  xit '#high item count' do
    high_item = @sa.merchants_with_high_item_count

    expect(high_item).to be_a(Array)
    expect(high_item.empty?).to be(false)
    expect(high_item.first).to be_a(Merchant)
    expect(high_item.length).to eq 52
  end

  xit '#average item price for merchant' do

    expect(@sa.average_item_price_for_merchant(12334105)).to be_a(BigDecimal)
    expect(@sa.average_item_price_for_merchant(12334105)).to eq 16.66
  end

  xit '#average_average_price' do

    expect(@sa.average_average_price_per_merchant).to be_a(BigDecimal)
    expect(@sa.average_average_price_per_merchant).to eq 350.29
  end

  xit '#golden items' do
    good_items = @sa.golden_items

    expect(good_items).to be_a(Array)
    expect(good_items.empty?).to be(false)
    expect(good_items.length).to eq 5
  end

  xit '#average_invoices_per_merchant' do
    expect(@sa.average_invoices_per_merchant).to eq 10.49
  end

  xit '#average_invoices_per_merchant_standard_deviation' do
    expect(@sa.average_invoices_per_merchant_standard_deviation).to eq 3.29
  end

  xit '#top_merchants_by_invoice_count' do
    top_merchants = @sa.top_merchants_by_invoice_count

    expect(top_merchants).to be_a Array
    expect(top_merchants.empty?).to be false
    expect(top_merchants.length).to eq 12
  end

  xit '#bottom_merchants_by_invoice_count' do
    bottom_merchants = @sa.bottom_merchants_by_invoice_count

    expect(bottom_merchants).to be_a Array
    expect(bottom_merchants.empty?).to be false
    expect(bottom_merchants.length).to eq 4
  end

  xit '#top_days_by_invoice_count' do
    days = @sa.top_days_by_invoice_count

    expect(days).to be_a Array
    expect(days.empty?).to be false
    expect(days).to eq ["Wednesday"]
  end

  xit '#invoice_status' do
    expect(@sa.invoice_status(:pending)).to eq 29.55
    expect(@sa.invoice_status(:shipped)).to eq 56.95
    expect(@sa.invoice_status(:returned)).to eq 13.5
  end

  xit '#invoice_paid_in_full' do
    expect(@sa.invoice_paid_in_full?(2)).to be(true)
    expect(@sa.invoice_paid_in_full?(10)).to be(true)
    expect(@sa.invoice_paid_in_full?(203)).to be(false)
  end

  xit '#invoice_total' do
    expect(@sa.invoice_total(1)).to eq(21067.77)
  end

  xit "#total_revenue_by_date" do
    date = Time.parse("2009-02-07")

    expect(@sa.total_revenue_by_date(date)).to eq(21067.77)
    expect(@sa.total_revenue_by_date(date).class).to eq(BigDecimal)
  end

  xit '#top_revenue_earners'do
  expected = @sa.top_revenue_earners
  first = expected.first
  last = expected.last

  expect(expected.length).to eq 20

  expect(first.class).to eq Merchant
  expect(first.id).to eq 12334634

  expect(last.class).to eq Merchant
  expect(last.id).to eq 12334159
  end

  xit "#merchants_with_only_one_item" do

    expect(@sa.merchants_with_only_one_item.length).to eq 243
    expect(@sa.merchants_with_only_one_item[0].class).to eq Merchant
  end

  xit "#merchants_with_only_one_item_registered_in_month" do
    expected = @sa.merchants_with_only_one_item_registered_in_month("March")

    expect(expected.length).to eq 21
    expect(expected.first.class).to eq Merchant

    expected = @sa.merchants_with_only_one_item_registered_in_month("June")

    expect(expected.length).to eq 18
    expect(expected.first.class).to eq Merchant

  end

  xit '#revenue_by_merchant' do
    expected = @sa.revenue_by_merchant(12334194)

    expect(expected).to eq BigDecimal(expected)
    expect(expected.class).to eq BigDecimal
  end

  xit '#merchants_with_pending_invoices' do
    expected = @sa.merchants_with_pending_invoices

    expect(expected.length).to eq 467
    expect(expected.first.class).to eq Merchant
  end

  it "#invoice_items_for_merchant" do
    expect(@sa.invoice_items_for_merchant(12334105)).to be_an(Array)
    expect(@sa.invoice_items_for_merchant(12334105)[0]).to be_an(InvoiceItem)
  end

  it "#invoice_items_grouped_by_quantity" do
    expect(@sa.invoice_items_grouped_by_quantity(12334105)).to be_a(Hash)
  end

  it '#most_sold_item_for_merchant' do

    expect(@sa.most_sold_item_for_merchant(12334105)).to be_an(Array)
    expect(@sa.most_sold_item_for_merchant(12334105)[0]).to be_an(Item)
    expect(@sa.most_sold_item_for_merchant(12334105)[0]).to eq(@sa.items.find_by_id(263396209))
  end
end
