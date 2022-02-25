require 'rspec'
require './lib/sales_engine.rb'
require './lib/sales_analyst.rb'

RSpec.describe SalesAnalyst do

  it 'sales ' do
    sales_engine = SalesEngine.new
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'sales ' do
    sales_engine = SalesEngine.new
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end




end
