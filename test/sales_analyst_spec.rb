require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/sales_analyst'

RSpec.describe SalesAnalyst do
  let(:sales_engine) do
    SalesEngine.from_csv({
                           items: './data/items.csv',
                           merchants: './data/merchants.csv'
                         })
    #  let(:sales_analyst) { sales_engine.analyst }
  end

  xit 'exists' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_instance_of(SalesAnalyst)
  end

  xit 'checks average items per merchant' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  xit 'checks average items per merchant standard deviation' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  xit 'returns merchants with high item counts' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.merchants_with_high_item_count).to be_a(Array)
    expect(sales_analyst.merchants_with_high_item_count[0]).to be_a(Merchant)
  end

  xit 'checks average item price for merchant)' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_item_price_for_merchant(12_334_159)).to be_a(BigDecimal)
  end

  xit '#average average price per merchant' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_average_price_per_merchant).to be_a(BigDecimal)
  end

  xit '#golden items' do
  sales_analyst = sales_engine.analyst
  expect(sales_analyst.golden_items).to be_a(Array)
  expect(sales_analyst.golden_items[0]).to be_a(Item)


end
end
