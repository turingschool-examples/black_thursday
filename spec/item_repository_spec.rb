require './lib/item_repository'

RSpec.describe ItemRepository do
  it "exists" do
    item_repo = ItemRepository.new('./data/items.csv')
    expect(item_repo).to be_a(ItemRepository)
  end
end
