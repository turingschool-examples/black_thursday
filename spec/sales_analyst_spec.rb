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

  it '#average_items_per_merchant_standard_deviation' do
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end


  it '#merchants_with_high_item_count' do #need better test
    expect(@sales_analyst.merchants_with_high_item_count).to be_a(Array)
  end

  it '#average_item_price_for_merchant' do
    expect(@sales_analyst.average_item_price_for_merchant(12334159)).to eq(3150)
  end

  it '#average_average_item_price_for_merchant' do
    expect(@sales_analyst.average_average_item_price_for_merchant).to be_a(Float)
  end

  xit '#golden_item' do
    expect(@sales_analyst.golden_item).to be_a(Array)
  end
end
