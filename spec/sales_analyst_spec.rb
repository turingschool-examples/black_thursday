require './lib/sales_analyst'
require './lib/sales_engine'

RSpec.describe SalesAnalyst do

  sales_analyst = sales_engine.analyst
  
  it 'exists' do
    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  it 'is able to find average items per merchant' do
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'is able to find the standard deviation' do
    expect (sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it 'is able to find merchants with high item counts' do
    expect(sales_analyst.merchants_with_high_item_count).to eq(Merchant)
  end

  it 'is able to find average price of merchant items' do
    expect(sales_analyst.average_item_price_for_merchant(12334159)).to eq(BigDecimal)
  end

  it 'is able to find average of average price per merchants' do
    expect(sales_analyst.average_average_price_per_merchant).to eq(BigDecimal)
  end

  it 'is able to find Golden items of merchants' do
    expect(sales_analyst.golden_items). to eq(Item)
  end
end
