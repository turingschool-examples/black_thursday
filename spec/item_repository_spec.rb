require 'csv'
require './lib/item'
require './lib/item_repository'

RSpec.describe ItemRepository do

  it "can return an array of all items" do
    item_repo1 = ItemRepository.new('./data/items.csv')
    expect(item_repo1.all.class).to be(Array)
  end
end
