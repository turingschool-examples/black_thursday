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

  it 'checks average items per merchnt' do
    sales_engine = SalesEngine.from_csv({
                                          items: './data/items.csv',
                                          merchants: './data/merchants.csv'
                                        })
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end
end
