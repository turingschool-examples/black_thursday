require './lib/item'
require './lib/sales_engine'
require './lib/item_repository'

RSpec.describe ItemRepository do
  before :each do
    @item_repository =ItemRepository.new("./data/items.csv")
  end

  it "exists" do
    expect(@item_repository).to be_a ItemRepository
  end

  it "can return an array of all known items" do
    expect(@item_repository.all).to be_a Array
    expect(@item_repository.all.first.id).to eq("263395237")
    expect(@item_repository.all.first.name).to eq("510+ RealPush Icon Set")
  end

  it "can find by id" do
    expect(@item_repository.find_by_id("1")).to eq nil
    expect(@item_repository.find_by_id("263395237")).to be_a(Item)
    expect(@item_repository.find_by_id("263400793")).to be_a(Item)
  end
end
