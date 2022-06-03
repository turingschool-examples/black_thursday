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

  it "can find an item by name" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo.find_by_name("Free standing Woden letters")).to be_instance_of(Item)
    expect(item_repo.find_by_name("FREE stANDing wOdeN lEttErs")).to be_instance_of(Item)
    expect(item_repo.find_by_name("InvalidName")).to eq(nil)
  end

  it "can return an item by parts of a description" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo.find_all_with_description("Disney")).to be_instance_of(Array)
    expect(item_repo.find_all_with_description("dISneY")).to be_instance_of(Array)
    expect(item_repo.find_all_with_description("Thiago")).to eq([])
  end

  it "can find all items by price" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo.find_all_by_price("1300")).to be_instance_of(Array)
    expect(item_repo.find_all_by_price("1,000,000")).to eq([])
  end
end
