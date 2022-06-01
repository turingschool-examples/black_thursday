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

  it 'returns array of all item instances' do
    expect(@item_repository.all).to be_instance_of(Array)
  end

  it 'returns array of all item instances' do
    expect(@item_repository.all.count).to be > 20
  end

end
