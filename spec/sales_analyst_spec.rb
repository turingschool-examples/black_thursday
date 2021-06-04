require 'SimpleCov'
SimpleCov.start

require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

RSpec.describe SalesEngine do
  before :each do
    @se = SalesEngine.from_csv({
      :items => './spec/fixture_files/item_fixture.csv',
      :merchants => './spec/fixture_files/merchant_fixture.csv'
      # :items     => './data/items.csv',
      # :merchants => './data/merchants.csv'
    })
    @sales_analyst = @se.analyst
  end

  it 'exists' do
    expect(@sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it 'can return average items per merchant' do
    expect(@sales_analyst.average_items_per_merchant).to eq(1.33)
  end

  it 'can return average items per merchant standard deviation' do
# 4 is the mean
# set = [3,4,5]
# std_dev = sqrt( ( (3-4)^2+(4-4)^2+(5-4)^2 ) / 2 )

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
    expect(@sales_analyst.merchants_with_high_item_count).to eq(@engine.merchants.find_by_id(4))
  end

  it 'can return the average item price for a specific merchant' do
    expect(@sales_analyst.average_item_price_for_merchant(4)).to eq(16) # => BigDecimal
  end

  it 'can return the average price per merchant' do
    expect(@sales_analyst.average_average_price_per_merchant).to eq(12.67) # => BigDecimal
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
