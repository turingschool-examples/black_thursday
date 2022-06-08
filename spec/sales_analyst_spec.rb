
require_relative "../lib/sales_engine"
require_relative "../lib/item_repository"
require_relative "../lib/merchant_repository"
require_relative "../lib/sales_analyst"
require_relative "../lib/invoice_item_repository"

RSpec.describe SalesAnalyst do
  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv'
    })
    @sales_analyst = @sales_engine.analyst
  end

  it 'exists' do

    expect(@sales_analyst).to be_instance_of SalesAnalyst
  # expect(@sales_analyst.items_path).to be_a Array
  end

  it 'can group all items by merchant id' do

    expect(@sales_analyst.all_items_by_merchant).to be_a Hash
  end

  it 'can return an array of the number of items per merchant' do

    expect(@sales_analyst.items_per_merchant).to be_a Array
    expect(@sales_analyst.items_per_merchant.length).to eq 475
  end

  it 'can calculate the average number of items per merchant' do

    expect(@sales_analyst.average_items_per_merchant).to eq 2.88
  end

  it 'calculates items per merchant standard deviation' do

    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it 'can find the difference of each number' do

    expect(@sales_analyst.difference_squared).to be_a Float
  end

  it 'can find find merchants with highest item count' do

    expect(@sales_analyst.merchants_with_high_item_count).to be_a Array
    expect(@sales_analyst.merchants_with_high_item_count.first).to be_a Merchant
  end

  it 'can find the sum of a merchants items' do

    expect(@sales_analyst.sum_of_of_item_price(12334159)).to eq 31500.0
  end

  it 'can find the average item price per merchant' do

    expect(@sales_analyst.average_item_price_for_merchant(12334159)).to be_a BigDecimal
    expect(@sales_analyst.average_item_price_for_merchant(12334159)).to eq(0.315e4)
  end

  it 'can find the average of average prices per merchant' do

    expect(@sales_analyst.average_average_price_per_merchant).to be_a BigDecimal
  end

  it 'can find items 2 standard deviations above average item price' do

    expect(@sales_analyst.golden_items).to be_a Array
    expect(@sales_analyst.golden_items.first).to be_a Item
  end
end
