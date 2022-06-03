require "./lib/sales_analyst"

RSpec.describe SalesAnalyst do
  before :each do
    @sales_engine = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    @sales_analyst = @sales_engine.analyst
  end

  it 'exists' do
    expect(@sales_engine).to be_a(SalesEngine)
    expect(@sales_analyst).to be_a(SalesAnalyst)
  end

  it 'creates a hash of merchants and their number of items' do
    expect(@sales_analyst.merchant_items_hash.count).to eq(475)
  end


  it 'gives average items per merchant' do
    # require "pry"; binding.pry
    expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'gives average items per merchant standard deviation' do
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it 'gives the merchants that sell the most items' do
    expect(@sales_analyst.merchants_with_high_item_count).to include(Merchant)
    expect(@sales_analyst.merchants_with_high_item_count.count).to eq(52)
  end
end
