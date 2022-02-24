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

  it "can find all items within a given range" do
    expect(@item_repo1.find_all_by_price_in_range(100..10000).length).to eq(1090)
    expect(@item_repo1.find_all_by_price_in_range(1000..2000).length).to eq(317)
    expect(@item_repo1.find_all_by_price_in_range(25..35)).to eq([])
  end

  it "can find all items by merchant id" do
    expect(@item_repo1.find_all_by_merchant_id(12334213).length).to eq(2)
    expect(@item_repo1.find_all_by_merchant_id(2)).to eq([])
  end

  it "can create a new instance of item with provided attributes" do
    expect(@item_repo1.find_all_by_merchant_id(12334213).length).to eq(2)
    @item_repo1.create({name: "Item name", description: "It's an item", unit_price: 1000, merchant_id: 12334213})
    expect(@item_repo1.find_all_by_merchant_id(12334213).length).to eq(3)
  end

  it "can update the Item instance to change attributes" do
    expect(@item_repo1.find_by_id(263416405).name).to eq("Tappeto pon pon")
    @item_repo1.update(263416405, {name: "nothing", description: "not really an item", unit_price: 160001})
    expect(@item_repo1.find_by_id(263416405).name).to eq("nothing")
  end
end
