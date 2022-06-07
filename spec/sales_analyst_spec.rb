require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_analyst'

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

  xit 'can find the average item price per merchant' do

    expect(@sales_analyst.merchants_with_high_item_count(12334159)).to be_a BigDecimal
  end
end
