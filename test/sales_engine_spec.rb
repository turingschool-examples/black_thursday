require './lib/sales_engine'
require './lib/item'
require 'bigdecimal'
require 'bigdecimal/util'
require 'rspec'
require 'csv'
require './lib/merchantrepository'
require '/lib/merchant'

describe SalesEngine do

  it 'exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se).to be_a(SalesEngine)
  end

  it "can create an array of items from csv input" do
     expect(se.items.find_by_id(263395721)).to be_an_instance_of(Item)
    expect(se.items.all.length).to eq(1367)
  end
end 