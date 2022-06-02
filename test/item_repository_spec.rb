require './lib/item_repository'

RSpec.describe ItemRepository do
  before :each do
    @items = ItemRepository.new("./data/items.csv")
  end

  it "is an instance of ItemRepository" do
    expect(@items).to be_a(ItemRepository)
  end

  it "can return an array of all known item instances" do
    expect(@items.all).to be_a(Array)
    expect(@items.all.first).to be_a(Item)
  end

  it "can find items by id" do
    expect(@items.find_by_id(263396013)).to be_a(Item)
    expect(@items.find_by_id("0")).to eq(nil)
  end
end
