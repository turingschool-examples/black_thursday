require './lib/item_repository'

RSpec.describe ItemRepository do
  before :each do
    @item_repo = ItemRepository.new("./data/items.csv")
  end

  it "will be an instance of ItemRepository" do
    expect(@item_repo).to be_instance_of ItemRepository
  end
end
