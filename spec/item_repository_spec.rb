require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/item_repository'
require 'bigdecimal'

RSpec.describe ItemRepository do
  describe '#initialize' do
    it 'exists' do
      ir = ItemRepository.new('./data/items.csv')

      expect(ir).to be_instance_of(ItemRepository)
    end

    it 'has items' do
      ir = ItemRepository.new('./data/items.csv')

      expect(ir.items.count).to eq(1367)
    end
  end

  describe '#make_items' do
    it 'makes_items' do
      ir = ItemRepository.new('./data/items.csv')

      expect(ir.items.first).to be_instance_of(Item)
    end
  end

  describe '#all' do
    it 'contains all the items' do
      ir = ItemRepository.new('./data/items.csv')

      expect(ir.all.count).to eq(1367)
    end
  end

  describe '#find_by_id' do
    it 'finds items by id' do
      ir = ItemRepository.new('./data/items.csv')
      test_item = Item.new(id: '1',
      name: 'Cool Stuff',
      description: 'supaaa cool',
      unit_price: '1300',
      merchant_id: '12334185',
      created_at: '2016-01-11 11:51:37 UTC',
      updated_at: '1993-09-29 11:56:40 UTC')
      ir.items << test_item

      expect(ir.find_by_id(1)).to eq(test_item)
      expect(ir.find_by_id(7)).to eq(nil)
    end
  end

  describe '#find_by_name' do
    it 'finds items by name' do
      ir = ItemRepository.new('./data/items.csv')
      test_item = Item.new(id: '1',
      name: 'Cool Stuff',
      description: 'supaaa cool',
      unit_price: '1300',
      merchant_id: '12334185',
      created_at: '2016-01-11 11:51:37 UTC',
      updated_at: '1993-09-29 11:56:40 UTC')
      ir.items << test_item

      expect(ir.find_by_name('CoOL StUfF')).to eq(test_item)
      expect(ir.find_by_name('neato')).to eq(nil)
    end
  end

  describe '#find_all_with_description' do
    it 'finds items by description' do
      ir = ItemRepository.new('./data/items.csv')
      test_item = Item.new(id: '1',
      name: 'Cool Stuff',
      description: 'supaaa cool',
      unit_price: '1300',
      merchant_id: '12334185',
      created_at: '2016-01-11 11:51:37 UTC',
      updated_at: '1993-09-29 11:56:40 UTC')
      ir.items << test_item

      expect(ir.find_all_with_description('sUPaAa')).to eq([test_item])
      expect(ir.find_all_with_description('neato burrito')).to eq([])
    end
  end

  describe '#find_all_by_price' do
    it 'finds items by price' do
      ir = ItemRepository.new('./data/items.csv')
      test_item = Item.new(id: '1',
      name: 'Cool Stuff',
      description: 'supaaa cool',
      unit_price: '1357',
      merchant_id: '12334185',
      created_at: '2016-01-11 11:51:37 UTC',
      updated_at: '1993-09-29 11:56:40 UTC')
      ir.items << test_item
      price_1 = BigDecimal(1357)
      price_2 = BigDecimal(7541234541)

      expect(ir.find_all_by_price(price_1)).to eq([test_item])
      expect(ir.find_all_by_price(7541234541)).to eq([])
    end
  end

  describe '#find_all_by_price_in_range' do
    it 'finds items by price range' do
      ir = ItemRepository.new('./data/items.csv')
      test_item = Item.new(id: '1',
      name: 'Cool Stuff',
      description: 'supaaa cool',
      unit_price: '1357',
      merchant_id: '12334185',
      created_at: '2016-01-11 11:51:37 UTC',
      updated_at: '1993-09-29 11:56:40 UTC')
      ir.items << test_item
      range_1 = (1000.00..1500.00)
      range_2 = (1..2)

      expect(ir.find_all_by_price_in_range(range_1).count).to eq(206)
      expect(ir.find_all_by_price_in_range(range_2)).to eq([])
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'finds items by merchant id' do
      ir = ItemRepository.new('./data/items.csv')
      test_item = Item.new(id: '1',
      name: 'Cool Stuff',
      description: 'supaaa cool',
      unit_price: '1357',
      merchant_id: '123456987',
      created_at: '2016-01-11 11:51:37 UTC',
      updated_at: '1993-09-29 11:56:40 UTC')
      ir.items << test_item

      expect(ir.find_all_by_merchant_id(123456987)).to eq([test_item])
      expect(ir.find_all_by_merchant_id(4)).to eq([])
    end
  end
end
