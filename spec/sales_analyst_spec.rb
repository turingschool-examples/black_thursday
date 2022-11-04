require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require "spec_helper_2"

RSpec.describe SalesAnalyst do
  let(:sales_analyst) { engine.analyst }

  it '#exists' do
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it 'can return the average num of items per merchant' do
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'can return the average num of items per merchant standard deviation' do
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it 'can return merchants with a high item count' do
    merchants_with_high_item_count_id = sales_analyst.merchants_with_high_item_count.map do |merchant|
      merchant.id
    end
    expect(merchants_with_high_item_count_id.include?(12334195)).to eq (true)
    expect(merchants_with_high_item_count_id.include?(12334105)).to eq (false)
  end

  it 'can return the average item price for a specific merchant' do
    expect(sales_analyst.average_item_price_for_merchant(12334159)).to eq 31.50
  end

  it 'can return the average number of invoices per merchant' do
    expect(sales_analyst.average_invoices_per_merchant).to eq (10.49)
  end

  it 'can return a hash of merchant ids with number of invoices per merchant' do
    expect(sales_analyst.inv_hash).to be_a Hash
  end

  it 'can return the average number of invoices per merchant standard deviation' do
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq (3.29)
  end
  it 'can return golden items' do
    expect(sales_analyst.golden_items.count).to eq(5)
    expect(sales_analyst.golden_items).to be_a(Array)
    expect(sales_analyst.golden_items[0]).to be_a(Item)
  end

  it 'can return the average average price per merchant' do
    expect(sales_analyst.average_average_price_per_merchant).to eq 350.29
    expect(sales_analyst.average_average_price_per_merchant.class).to eq BigDecimal
  end

  it 'can return the percentage of invoices for a given status' do
    expect(sales_analyst.invoice_status(:pending)).to eq 29.55
    expect(sales_analyst.invoice_status(:shipped)).to eq 56.95
    expect(sales_analyst.invoice_status(:returned)).to eq 13.5
  end

  it 'can return the days of the week with the most sales' do
    expect(sales_analyst.top_days_by_invoice_count).to eq(['Wednesday'])
  end

  it 'can return top merchants by invoice count' do
    expect(sales_analyst.top_merchants_by_invoice_count.first).to be_a(Merchant)
    expect(sales_analyst.top_merchants_by_invoice_count.length).to eq(12)
  end

  it 'can return bottom merchants by invoice count' do
    expect(sales_analyst.bottom_merchants_by_invoice_count.first).to be_a(Merchant)
    expect(sales_analyst.bottom_merchants_by_invoice_count.length).to eq(4)
  end

  it 'can return if an invoice is paid in full based on an invoice id' do
    expect(sales_analyst.invoice_paid_in_full?(3374)).to eq true
    expect(sales_analyst.invoice_paid_in_full?(1202)).to eq false
  end

  it 'can return the total dollar amount paid for a specific invoice' do
    expect(sales_analyst.invoice_total(1)).to eq 21067.77
  end
end
