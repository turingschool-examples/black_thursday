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
      # require "pry"; binding.pry
      price_in_range = @item_repository.find_all_by_price_in_range(0..500)
      expect(price_in_range).to be_a(Array)
      expect(price_in_range.first.id).to eq("263397163")
    end

    it 'can find all merchants by merchant id' do
      merchant_id = @item_repository.find_all_by_merchant_id("263395237")
      expect(merchant_id).to be_a(Array)
      expect(merchant_id.first.id).to eq("263395237")
    end

    it "can create a new instance" do
      @item_repository.create("ants")
      expect(@item_repository.all.last).to be_a Item
      expect(@item_repository.all.last.name).to eq("ants")
      expect(@item_repository.all.last.id).to eq("263567475")
    end

    it "can can update item instances "do
    @item_repository.update("263395237", "test")
    expect(@item_repository.find_by_id("263395237").name).to eq("test")
    end
    it "can find and item by id and return nil if not found" do
      expect(@item_repository.find_by_id("1")).to eq nil
      expect(@item_repository.find_by_id("263395237")).to be_a(Item)
      expect(@item_repository.find_by_id("263400793")).to be_a(Item)
    end

    it "can find and item by name and return nil if not found" do
      expect(@item_repository.find_by_name("Glitter scrabble frames")).to be_a(Item)
      expect(@item_repository.find_by_name("Cache cache à la plage")).to be_a(Item)
      expect(@item_repository.find_by_name("zero")).to eq nil
    end

    it "can find an item by description and return an array or instances of item" do
      expect(@item_repository.find_all_with_description("Acrylique")).to be_a(Array)
      expect(@item_repository.find_all_with_description("Acrylique sur toile exécutée en 2009")[0]).to be_a(Item)
      expect(@item_repository.find_all_with_description("Acrylique sur toile exécutée en 2012")[0]).to be_a(Item)
      expect(@item_repository.find_all_with_description("ideal for a romantic date")[0]).to be_a(Item)
    end

    xit "can find an item that exactly matches by supplied price" do
      item_price = @item_repository.find_all_by_price("263395237")
      expect(item_price).to be_a(Array)
      expect(item_price).to eq("263395237")
    end

    it "can delete the merchant instace" do
      @item_repository.delete("263395617")
      expect(@item_repository.all.first.id).to eq("263395237")
    end
end
