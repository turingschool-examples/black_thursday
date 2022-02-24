require 'csv'
require './lib/item'
require './lib/item_repository'

RSpec.describe ItemRepository do
  before (:each) do
    @item_repo1 = ItemRepository.new('./data/items.csv')
  end

  describe "instantiation" do
    it "exists" do
      expect(@item_repo1).to be_a(ItemRepository)
    end

    it "has readable attributes" do
      expect(@item_repo1.all.length).to eq(1367)
    end
  end

  it "can return an array of all items" do
    expect(@item_repo1.all.class).to be(Array)
  end

  it "can find all items by description" do
    expect(@item_repo1.find_all_with_description("Acrylique sur toile et collage.")[0].name).to eq("Moyenne toile")
    expect(@item_repo1.find_all_with_description("Stupid Fart Face.")).to eq([])
  end

  it "can find all items by price" do
    expect(@item_repo1.find_all_by_price(1790)).to include(@item_repo1.all[249])
    expect(@item_repo1.find_all_by_price(0)).to eq([])
  end
end
