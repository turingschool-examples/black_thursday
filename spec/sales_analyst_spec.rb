require 'SimpleCov'
SimpleCov.start

require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

RSpec.describe SalesEngine do
  before :each do
    @se = SalesEngine.from_csv({
                                :items => './spec/fixture_files/item_fixture.csv',
                                :merchants => './spec/fixture_files/merchant_fixture.csv'
                              })
    @sales_analyst = @se.analyst
  end

  it 'exists' do
    expect(@sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it 'can return average items per merchant' do
    expect(@sales_analyst.average_items_per_merchant).to eq(1.33)
  end

  it 'can return a hash of the merchant ids and items' do
    expected = {
                5 => @se.items.find_all_by_merchant_id(5),
                6 => @se.items.find_all_by_merchant_id(6),
                7 => @se.items.find_all_by_merchant_id(7)
               }
    expect(@sales_analyst.merch_items_hash).to eq(expected)
  end

  it 'can return items by merchant count' do
    expect(@sales_analyst.items_by_merch_count).to eq([1, 1, 2])
  end

  it 'can return average items per merchant standard deviation' do
    # 1.33 is the mean
    # set = [1, 1, 2]
    # std_dev = sqrt( ( (1-1.33)^2+(1-1.33)^2+(2-1.33)^2 ) / 2 )
    # std_dev = sqrt( ( .6667 / 2 )
    # std_dev = sqrt( ( .33335 )
    # std_dev = .578
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(0.58)
  end

  it 'can return merchants with high item count' do
    expect(@sales_analyst.merchants_with_high_item_count.length).to eq(1)
    expect(@sales_analyst.merchants_with_high_item_count).to eq([@se.merchants.find_by_id(7)])
  end

  it 'can return the item prices for a specific merchant' do
    expect(@sales_analyst.price_of_items_for_merch(7)).to eq([12.0, 20.0]) # => BigDecimal
  end

  it 'can return the average item price for a specific merchant' do
    expect(@sales_analyst.average_item_price_for_merchant(7)).to eq(16) # => BigDecimal
  end

  it 'can return the average price per merchant' do
    expect(@sales_analyst.average_average_price_per_merchant).to eq(12.67) # => BigDecimal
  end

  it 'can return a set of item prices' do
    expect(@sales_analyst.item_price_set).to eq([10, 12, 12, 20])
  end

  it 'can average prices of items' do
    expect(@sales_analyst.average_price_per_item).to eq(13.50)
  end

  it 'can average prices of items by standard deviation' do
    expect(@sales_analyst.average_price_per_item_standard_deviation).to eq(5.43)
  end

  it 'can return golden items' do
    expect(@sales_analyst.golden_items).to eq([]) # => [<item>, <item>, <item>, <item>]
    # find average item price
    # find the standard deviation of the item price
    # array will be items that are 2+ std dev above the average item price
    # 13.5 is the mean
    # set = [10, 12, 12, 20]
    # std_dev = sqrt( ( (10-13.5)^2+(12-13.5)^2+(12-13.5)^2+(20-13.5)^2 ) / 2 )
    # std_dev = sqrt( ( 12.25 + 2.25 + 2.25 + 42.25 ) / 2 )
    # std_dev = sqrt( ( 59 / 2 )
    # std_dev = sqrt( ( 29.5 )
    # std_dev = 5.43
  end
end
