require 'rspec'
require './lib/sales_engine'
require './lib/item'
require './lib/itemrepository'
require './lib/sales_analyst'
require './lib/merchant.rb'
require './lib/merchant_repository.rb'


RSpec.describe SalesAnalyst do
  it 'exists' do
    sales_engine = SalesEngine.new
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    expect(sales_analyst.purple).to eq(0)
  end
end
