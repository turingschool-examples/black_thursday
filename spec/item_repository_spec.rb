require './lib/item'
require './lib/item_repository'
require 'bigdecimal'

describe ItemRepository do
  before(:each) do
    @items1 = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    @items2 = {
      :id          => 2,
      :name        => "Book",
      :description => "You write things in this",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 5
    }

    @item1 = Item.new(@items1)
    @item2 = Item.new(@items2)

    @ir = ItemRepository.new([@item1, @item2])
  end

  describe '#initialization' do
    it 'exists' do
      expect(@ir).to be_instance_of(ItemRepository)
    end
  end

  describe '#all' do
    it 'returns list of all added items' do
      expect(@ir.all).to eq([@item1, @item2])
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
end