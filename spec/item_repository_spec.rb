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
  end

  it "can return an instance of an Item within a price range" do
    # expect(@item_repository.find_all_by_price_in_range(0..0)).to eq([])
    expect(@item_repository.find_all_by_price_in_range(0..500)).to eq(@item)
  end
end
