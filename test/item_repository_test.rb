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

  it 'returns item instance by ID' do
    expect(@item_repository.find_by_id(263438579).name).to eq("Air Jordan Coloring Book")
  end

  it 'returns item instance by name' do
    expect(@item_repository.find_by_name("Air Jordan Coloring Book").id).to eq("263438579")
  end

  it 'returns item instance by name, case insensitive' do
    expect(@item_repository.find_by_name("Air JORDAN Coloring BoOK").id).to eq("263438579")
  end

end
