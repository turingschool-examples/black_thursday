require './lib/item_repository'
require './lib/item'
require 'bigdecimal'

RSpec.describe ItemRepository do
  let(:ir) { ItemRepository.new }
  let(:item_1) { Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2}) }

  let(:item_2) { Item.new({
        :id          => 2,
        :name        => "Pen",
        :description => "You can use it to permanently write things",
        :unit_price  => BigDecimal(12.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 7}) }

  describe '#initialize' do
    it 'exists' do
      expect(ir).to be_a(ItemRepository)
    end
    
    it 'starts with an empty array' do
      expect(ir.all).to eq([])
    end
  end

  describe '#find_by_id()' do
    it 'finds an instance of Item with matching ID' do
      expect(ir.find_by_id(4)).to eq(nil)
    end
  end
end