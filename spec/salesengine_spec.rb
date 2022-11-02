require './lib/salesengine.rb'
require './lib/item.rb'
require 'csv'

RSpec.describe SalesEngine do

  it 'exists' do
    se = SalesEngine.new
    
      expect(se).to be_a(SalesEngine)
  end

  it 'can have an item repository' do
    files = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }
    se = SalesEngine.new(files)

    expect(se.items.all.all?(Item)).to be(true)
  end
end
