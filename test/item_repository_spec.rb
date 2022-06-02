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


end
