require 'rspec'
require './lib/sales_engine'
require './lib/item'
require './lib/itemrepository'
require './lib/sales_analyst'
require './lib/merchant.rb'
require './lib/merchant_repository.rb'


RSpec.describe SalesAnalyst do
  before :each do

    @sales_engine = SalesEngine.new
    @sales_analyst = @sales_engine.analyst





  end

  it 'exists' do
    expect(@sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it '#average_items_per_merchant' do
    expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
  end
end
