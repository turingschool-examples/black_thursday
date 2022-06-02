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
    expect(@item_repository.all_items).to be_a Array
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
  end
