require './lib/item'
require './lib/item_repository'
require 'bigdecimal'

describe ItemRepository do
  before(:each) do
    @stats1 = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    @stats2 = {
      :id          => 2,
      :name        => "Book",
      :description => "You write things in this",
      :unit_price  => BigDecimal(14.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 5
    }
    @stats3 = {
      :id          => 3,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 7
    }

    @item1 = Item.new(@stats1)
    @item2 = Item.new(@stats2)
    @item3 = Item.new(@stats3)

    @ir = ItemRepository.new([@item1, @item2, @item3])
  end

  describe '#initialization' do
    it 'exists' do
      expect(@ir).to be_instance_of(ItemRepository)
    end
  end

  describe '#all' do
    it 'returns list of all added items' do
      expect(@ir.all).to eq([@item1, @item2, @item3])
    end
  end

  describe '#find_by_id' do
    it 'searches for specific item id and returns item' do
      expect(@ir.find_by_id(2)).to eq(@item2)
    end
  end

  describe '#find_by_name' do
    it 'searches for specific name and returns item' do
      expect(@ir.find_by_name("Book")).to eq(@item2)
    end
  end

  describe '#find_by_description' do
    it 'searches for specific description and returns items found' do
      expect(@ir.find_by_description("You can use it to write things")).to eq([@item1, @item3])
    end
  end

  describe '#find_all_by_price' do
    it 'searches for specific price and returns items' do
      expect(@ir.find_all_by_price(14.99)).to eq([@item2])
    end
  end

  describe '#find_all_by_price_range' do
    it 'searches for specific price range and returns items' do
      expect(@ir.find_all_by_price_range(10..14)).to eq([@item1, @item3])
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'searches for merchant id and returns items' do
      expect(@ir.find_all_by_merchant_id(2)).to eq([@item1])
    end
  end
end