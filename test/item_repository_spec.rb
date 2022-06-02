require './lib/item_repository'
require './lib/item'

  RSpec.describe ItemRepository do
    before :each do
      @item_repository = ItemRepository.new('./data/items.csv')
    end

    it "exists" do
      expect(@item_repository).to be_a(ItemRepository)
    end

    it "returns an array of all known Item instances" do
      expect(@item_repository.all).to be_a(Array)
    end

    it "can be found by id" do
      expect(@item_repository.find_by_id(123)).to eq(nil)
      # expect(@item_repository.find_by_id(263395617)).to be_a(Item)
      # expect(@item_repository.find_by_id(263395617)).to eq("Disney scrabble frames")
    end

    it "can be found by name" do
      expect(@item_repository.find_by_name("Hello World")).to eq(nil)
      expect(@item_repository.find_by_name("disney scrabble frames")).to be_a(Item)
      expect(@item_repository.find_by_name("Disney scrabble frames")).to be_a(Item)
    end

    it "can be found with the description" do
      expect(@item_repository.find_all_with_description("abc")).to eq([])
    end

    it "can find_all_by_price" do
      expect(@item_repository.find_all_by_price(100)).to eq([])
    end

    it "can find_all_by_price_in_range" do
      expect(@item_repository.find_all_by_price_in_range(1..5)).to eq([])
    end

    it "can find_all_by_merchant_id" do
      expect(@item_repository.find_all_by_merchant_id(00000)).to eq([])
    end

    

end
