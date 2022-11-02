require './lib/salesengine.rb'
require './lib/item_repository.rb'
require './lib/item.rb'
require 'csv'

RSpec.describe SalesEngine do

  it 'exists' do
    files = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }
    se = SalesEngine.new(files)

    expect(se).to be_a(SalesEngine)
  end

  it 'can have an item repository' do
    files = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }
    se = SalesEngine.new(files)
require 'pry'; binding.pry
    expect(se.items.all.all?(Item)).to be(true)
  end
end
