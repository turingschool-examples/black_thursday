require './lib/item.rb'
require './lib/item_repository'

RSpec.describe ItemRepository do
  it "exists" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo).to be_a(ItemRepository)
  end

  it "can return an array of all known item instances" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo.all.count).to eq(1367)
  end

  it "can find item by ID" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo.find_by_id(263400305)).to be_a(Item)
    expect(item_repo.find_by_id(12345678910)).to eq(nil)
  end
end
