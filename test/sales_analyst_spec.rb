require './lib/sales_engine'
require './lib/sales_analyst'

RSpec.describe SalesAnalyst do
  it 'exists' do
    sales_engine = SalesEngine.from_csv({
                                items: './data/items.csv',
                                merchants: './data/merchants.csv'
                              })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_instance_of(SalesAnalyst)
  end
end