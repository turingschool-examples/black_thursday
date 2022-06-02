require './lib/item_repository'
require './lib/item'

  RSpec.describe ItemRepository do
    before :each do
      @item_repository = ItemRepository.new('./data/items.csv')
      @i = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
      })
      @pencil = {
        :id          => 263567475,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
        }
        @pencil_1 = {
          :id          => 263567475,
          :name        => "Mechanical Pencil",
          :description => "You can use it to write things mechanically",
          :unit_price  => BigDecimal(19.99,4),
          :created_at  => Time.now,
          :updated_at  => Time.now,
          :merchant_id => 2
          }
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
      expect(@item_repository.find_all_by_price(101)).to eq([])
    end

    it "can find_all_by_price_in_range" do
      expect(@item_repository.find_all_by_price_in_range(1..5)).to eq([])
    end

    it "can find_all_by_merchant_id" do
      expect(@item_repository.find_all_by_merchant_id(00000)).to eq([])
    end

    it "can create new item" do
      expect(@item_repository.find_by_id(263567475)).to be_nil
      # require 'pry'; binding.pry

      @item_repository.create(@pencil)

      expect(@item_repository.find_by_id(263567475)).to be_a(Item)
      expect(@item_repository.find_by_id(263567475).name).to eq("Pencil")
    end

    it "can update items" do
      @item_repository.create(@pencil)

      expect(@item_repository.find_by_id(263567475).name).to eq("Pencil")
        @item_repository.update(263567475, @pencil_2)

        expect(@item_repository.find_by_id(263567475).name).to eq("Mechanical Pencil")
    end

    xit "can delete items" do

    end
end
