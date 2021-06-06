require 'SimpleCov'
SimpleCov.start

require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

RSpec.describe SalesEngine do
  before :each do
    @se = SalesEngine.from_csv({
                                :items => './spec/fixture_files/item_fixture.csv',
                                :merchants => './spec/fixture_files/merchant_fixture.csv',
                                :invoices => './spec/fixture_files/invoice_fixture.csv'
                              })
    @sales_analyst = @se.analyst
  end

  it 'exists' do
    expect(@sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it 'can return average items per merchant' do
    expect(@sales_analyst.average_items_per_merchant).to eq(1.67)
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
    expect(@sales_analyst.items_by_merch_count).to eq([1, 1, 3])
  end

  it 'can return average items per merchant standard deviation' do
    # 1.33 is the mean
    # set = [1, 1, 2]
    # std_dev = sqrt( ( (1-1.33)^2+(1-1.33)^2+(2-1.33)^2 ) / 2 )
    # std_dev = sqrt( ( .6667 / 2 )
    # std_dev = sqrt( ( .33335 )
    # std_dev = .578
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(1.15)
  end

  it 'can return merchants with high item count' do
    expect(@sales_analyst.merchants_with_high_item_count.length).to eq(1)
    expect(@sales_analyst.merchants_with_high_item_count).to eq([@se.merchants.find_by_id(7)])
  end

  it 'can return the item prices for a specific merchant' do
    expect(@sales_analyst.price_of_items_for_merch(7)).to eq([12.0, 20.0, 10_000.0])
  end

  it 'can return the average item price for a specific merchant' do
    expect(@sales_analyst.average_item_price_for_merchant(7)).to eq(3_344)
  end

  it 'can return the average price per merchant' do
    expect(@sales_analyst.average_average_price_per_merchant).to eq(1_122)
  end

  it 'can return a set of item prices' do
    expect(@sales_analyst.item_price_set).to eq([10, 12, 12, 20, 10_000])
  end

  it 'can average prices of items' do
    expect(@sales_analyst.average_price_per_item).to eq(2_010.80)
  end

  it 'can average prices of items by standard deviation' do
    expect(@sales_analyst.average_price_per_item_standard_deviation).to eq(4_466.10)
  end

  it 'can return golden items' do
    expect(@sales_analyst.golden_items).to eq([])
    # 13.5 is the mean item price
    # set = [10, 12, 12, 20]
    # std_dev = sqrt( ( (10-13.5)^2+(12-13.5)^2+(12-13.5)^2+(20-13.5)^2 ) / 2 )
    # std_dev = sqrt( ( 12.25 + 2.25 + 2.25 + 42.25 ) / 2 )
    # std_dev = sqrt( ( 59 / 2 )
    # std_dev = sqrt( ( 29.5 )
    # std_dev = 5.43
  end

  it 'can return average invoices per merchant' do
    expect(@sales_analyst.average_invoices_per_merchant).to eq(1.67)
  end

  it 'can return average invoices per merchant standard deviation' do
  # 1.67 is the mean
  # set = [2, 1, 2] # number of invoices per merchant
  # std_dev = sqrt( ( (2-1.67)^2+(1-1.67)^2+(2-1.67)^2 ) / 2 )
  # std_dev = sqrt( ( 0.1089 + 0.4489 + 0.1089 ) / 2 )
  # std_dev = sqrt( ( .6667 / 2 ) )
  # std_dev = sqrt( 0.33335 )
  # std_dev = 0.57736
    expect(@sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(0.58)
  end

  it 'can return merchants with high invoice count' do
    expect(@sales_analyst.top_merchants_by_invoice_count).to eq([])
  end

  it 'can return merchants with low invoice count' do
    expect(@sales_analyst.bottom_merchants_by_invoice_count).to eq(@se.merchants.all)
  end

  it 'can return the top days invoices are created' do
    expect(@sales_analyst.top_days_by_invoice_count).to eq() # => [Saturday"] ?
  end

  it 'can return the percentage of invoice shipped vs pending vs returned' do
    expect(@sales_analyst.invoice_status(:pending)).to eq(60.0)
    expect(@sales_analyst.invoice_status(:shipped)).to eq(40.0)
    expect(@sales_analyst.invoice_status(:returned)).to eq(0)
  end
end
