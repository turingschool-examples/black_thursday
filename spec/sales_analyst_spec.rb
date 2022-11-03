require_relative '../lib/sales_engine.rb'
require_relative '../lib/item_repository.rb'
# require './lib/item.rb'
# require './lib/merchant.rb'
# require './lib/merchant_repository.rb'
require_relative '../lib/sales_analyst'
require 'csv'

RSpec.describe SalesAnalyst do
  it 'exists' do
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  it 'calculates the average items per merchant' do
    sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
    })
    sales_analyst = sales_engine.analyst
    #require 'pry' ;binding.pry
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end
end
