require './lib/sales_analyst'
require './lib/sales_engine'

RSpec.describe SalesAnalyst do
  it '#exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sales_analyst = se.analyst
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it 'can return the average num of items per merchant' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sales_analyst = se.analyst
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end


end
