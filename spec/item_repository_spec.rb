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
end
