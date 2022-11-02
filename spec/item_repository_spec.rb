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
      ir.add_to_repo(item_1)
      ir.add_to_repo(item_2)

      expect(ir.find_by_id(4)).to eq(nil)
      expect(ir.find_by_id(1)).to eq(item_1)
    end
  end

  describe '#find_by_name()' do
    it 'finds an instance of Item with case intensive search' do
      ir.add_to_repo(item_1)
      ir.add_to_repo(item_2)

      expect(ir.find_by_name("Pen")).to eq(item_2)
    end
  end

  describe '#find_all_with_description()' do
    it 'finds an instance of Item using description' do
      ir.add_to_repo(item_1)
      ir.add_to_repo(item_2)

      expect(ir.find_all_with_description("You can use it to write things")).to eq(item_1)
    end
  end

  describe '#find_all_with_price()' do
    it 'finds an instance of Item by price' do
      ir.add_to_repo(item_1)
      ir.add_to_repo(item_2)

      expect(ir.find_all_with_price(12.99)).to eq(item_2)
    end
  end

  describe '#()' do
    xit 'finds an instance of Item with case intensive search' do
      ir.add_to_repo(item_1)
      ir.add_to_repo(item_2)

      expect(ir.find_by_name("Pen")).to eq(item_2)
    end
  end


  describe '#find_merchant_by_id()' do
    it 'finds an instance of Item by merchant' do
      ir.add_to_repo(item_1)
      ir.add_to_repo(item_2)

      expect(ir.find_all_by_merchant_id(2)).to eq(item_2)
    end
  end

  


end