require_relative "../lib/sales_analyst"
require_relative "../lib/sales_engine"
require 'rspec'

describe SalesAnalyst do
  before :each do
    @se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv'
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

  it '#average_invoices_per_merchant' do
    expect(@sa.average_invoices_per_merchant).to eq 10.49
  end

  it "#average_invoices_per_merchant_standard_deviation" do
    expect(@sa.average_invoices_per_merchant_standard_deviation).to eq 3.29
  end
end
