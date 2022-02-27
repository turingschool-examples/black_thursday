require_relative '../lib/sales_engine'
require 'pry'
require 'bigdecimal'

RSpec.describe ItemRepository do
  before(:each) do
    @se = SalesEngine.from_csv({
                                 items: './data/items.csv',
                                 merchants: './data/merchants.csv'
                               })
    @sa = @se.analyst

  end

  it "#average_items_per_merchant returns average items per merchant" do
    expected = @sa.average_items_per_merchant

    expect(expected).to eq 2.88
    expect(expected.class).to eq Float
  end

  it "#average_items_per_merchant_standard_deviation returns the standard deviation" do
    expected = @sa.average_items_per_merchant_standard_deviation
    expect(expected).to eq 3.26
    expect(expected.class).to eq Float
  end

  it "returns #merchants_with_high_item_count" do
    expected = @sa.merchants_with_high_item_count

    expect(expected.length).to eq 52
    expect(expected.first.class).to eq Merchant
  end

  it "#average_item_price_for_merchant returns the average item price for the given merchant" do
    merchant_id = 12334132
    expected = @sa.average_item_price_for_merchant(merchant_id)

    expect(expected).to eq 35.00
    expect(expected.class).to eq BigDecimal
  end
end
