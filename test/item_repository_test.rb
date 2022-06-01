require 'simplecov'
SimpleCov.start
require './lib/item'
require './lib/item_repository'
require 'rspec'

RSpec.describe ItemRepository do

  before :each do
    @item_repository = ItemRepository.new("./data/items.csv")
  end

  it 'exists' do
    expect(@item_repository).to be_instance_of(ItemRepository)
  end

end
