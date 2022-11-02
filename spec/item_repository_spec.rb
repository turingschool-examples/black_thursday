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

  let(:item_3) { Item.new({
        :id          => 3,
        :name        => "Stapler",
        :description => "Attaches pieces of paper together",
        :unit_price  => BigDecimal(19.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 3}) }

  let(:item_4) { Item.new({
        :id          => 4,
        :name        => "Keyboard",
        :description => "Allows text input to a computer",
        :unit_price  => BigDecimal(29.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 9}) }

  let(:item_5) { Item.new({
        :id          => 5,
        :name        => "Mouse",
        :description => "Moves the cursor around",
        :unit_price  => BigDecimal(23.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 9}) }

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

      expect(ir.find_all_with_price(12.99)).to eq([item_2])
    end
  end

  describe '#find_all_with_price_in_range()' do
    it 'finds an instance of Item with case insensitive search' do
      ir.add_to_repo(item_1)
      ir.add_to_repo(item_2)
      ir.add_to_repo(item_3)
      ir.add_to_repo(item_4)

      expect(ir.find_all_with_price_in_range(19..30)).to eq([item_3, item_4])
      expect(ir.find_all_with_price_in_range(0..9)).to eq([])
      expect(ir.find_all_with_price_in_range(19.99..21.21)).to eq([item_3])
    end
  end

  describe '#find_all_by_merchant_by_id()' do
    it 'finds all instances of items by a merchant id' do
      ir.add_to_repo(item_1)
      ir.add_to_repo(item_2)
      ir.add_to_repo(item_3)
      ir.add_to_repo(item_4)
      ir.add_to_repo(item_5)

      expect(ir.find_all_by_merchant_id(9)).to eq([item_4, item_5])
      expect(ir.find_all_by_merchant_id(5)).to eq([])
    end
  end
  
  describe '#create(attributes)' do
    it 'creates a new Item instance with provided attributes' do
      expect(ir.all).to eq([])      

      ir.add_to_repo(item_1)
      expect(ir.all.count).to eq(1)      

      ir.create({
        :name        => "Eraser",
        :description => "Erases pencil markings",
        :unit_price  => BigDecimal(2.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2})      

      ir.create({
        :name        => "Scissors",
        :description => "They cut things",
        :unit_price  => BigDecimal(7.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => 2})      

      expect(ir.all[1].id).to eq(2)
      expect(ir.all[2].id).to eq(3)
      expect(ir.all[1].name).to eq("Eraser")
      expect(ir.all[2].name).to eq("Scissors")
      expect(ir.all[1]).to be_a(Item) 
    end
  end

  describe '#update(id, attributes)' do
    xit 'updates an items name, description, unit price and updated time' do
      ir.add_to_repo(item_1)
      ir.add_to_repo(item_2)
      ir.add_to_repo(item_3)

      expect(ir.all.first.name).to eq("Pencil") 

      ir.update(1,{
        :name        => "Mechanical Pencil",
        :description => "Writes things with replaceable lead",
        :unit_price  => BigDecimal(5.99,4),
        })

      expect(ir.all.first.name).to eq("Mechanical Pencil") 
    end
  end

  describe '#delete(id)' do
    xit 'deletes an item from the all array' do
      ir.add_to_repo(item_1)
      ir.add_to_repo(item_2)
      ir.add_to_repo(item_3)
      
    end
  end
end