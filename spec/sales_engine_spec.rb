require 'rspec'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchants_repository'
require './lib/items'
require './lib/item_repository'
require 'csv'

describe SalesEngine do

  describe it 'is an instance of sales engine class' do
   se = SalesEngine.new({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    expect(se).to be_an_instance_of SalesEngine
  end

  it 'has readable attributes' do
    se = SalesEngine.new({
     :items     => "./data/items.csv",
     :merchants => "./data/merchants.csv",
     })

     expect(se.merchants).to eq("./data/merchants.csv")
     expect(se.items).to eq("./data/items.csv")

  end
end
