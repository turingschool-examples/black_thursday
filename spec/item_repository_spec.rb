require 'rspec'
require './lib/item_repository'

describe ItemRepository do
  describe '#initialize' do
    it 'exists' do
      ir = ItemRepository.new

      expect(ir).to be_a(ItemRepository)
    end

    it 'starts with empty items array' do
      ir = ItemRepository.new

      expect(ir.items).to eq []
    end
  end

  describe '#all' do
    it 'returns all known instances' do
      ir = ItemRepository.new
      i = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
      })

      ir.items << i

      expect(ir.all).to eq([i])
    end
  end

  describe '#find_by_id' do
    it 'can find all items by id' do
      ir = ItemRepository.new
      i1 = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2
      })

      i2 = Item.new({
        :id          => 2,
        :name        => "Pen",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(15.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 3
      })
        

      ir.items << i1
      ir.items << i2

      expect(ir.find_by_id(1)).to eq i1
      expect(ir.find_by_id(2)).to eq i2
      expect(ir.find_by_id(3)).to eq nil
    end
  end
end