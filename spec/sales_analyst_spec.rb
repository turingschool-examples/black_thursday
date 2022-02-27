require 'rspec'
require './lib/sales_engine.rb'
require './lib/sales_analyst.rb'

RSpec.describe SalesAnalyst do

  xit 'sales ' do
    sales_engine = SalesEngine.new
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  xit 'sales ' do
    sales_engine = SalesEngine.new
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end


  xit 'standard deviation above average' do
    sales_engine = SalesEngine.new
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.merchants_with_high_item_count.length).to eq(52)
  end

  xit 'can see the number of items for a given merchant' do
    sales_engine = SalesEngine.new
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_item_price_for_merchant("12334185")).to eq(6)
  end

  xit "average item price for  merchant" do
    sales_engine = SalesEngine.new
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_item_price_for_merchant("12334145")).to eq(0.25e4)
  end

  xit "average item price per merchant" do
    sales_engine = SalesEngine.new
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_item_price_per_merchant).to eq(45)
  end

  it "standard deviation of item price"
    sales_engine = SalesEngine.new
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.standard_deviation_of_item_price).to eq(45)

end
