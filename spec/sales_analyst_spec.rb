require './lib/sales_analyst'
require './lib/sales_engine'

RSpec.describe SalesAnalyst do
  it '#exists' do
    sales_analyst = SalesAnalyst.new
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  


end
