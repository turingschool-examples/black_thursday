require 'csv'
require './lib/item'
require './lib/item_repository'

RSpec.describe ItemRepository do

  it "exists" do
    item_repo1 = ItemRepository.new('./data/items.csv')
    expect(item_repo1).to be_an_instance_of(ItemRepository)
  end 

  it "can return an array of all items" do
    item_repo1 = ItemRepository.new('./data/items.csv')
    expect(item_repo1.all.class).to be(Array)
  end
end
