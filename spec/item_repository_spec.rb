require 'rspec'
require 'bigdecimal'
require './lib/item'
require './lib/item_repository'

describe ItemRepository do
  describe '#initialize' do
    it 'exists' do
      items = []
      item_repository = ItemRepository.new(items)

      expect(item_repository).is_a? ItemRepository
    end

    it 'has an items array' do
      items = []
      item_repository = ItemRepository.new(items)

      expect(item_repository.items).to eq []
    end
  end

  describe '#all' do
    it 'returns a list of all items' do
      item1 = instance_double("Item")
      item2 = instance_double("Item")
      items = [item1, item2]
      item_repository = ItemRepository.new(items)

      expect(item_repository.all).to eq [item1, item2]
    end
  end

  describe '#find_by_id' do
    it 'returns nil if no item has the specified id' do
      details = {
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: BigDecimal(10.99,4),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }
      item = Item.new(details)
      item_repository = ItemRepository.new([item])

      expect(item_repository.find_by_id(2)).to eq nil
    end

    it 'returns nil if no item has the specified id' do
      details = {
        id: 1,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: BigDecimal(10.99,4),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }
      item = Item.new(details)
      item_repository = ItemRepository.new([item])

      expect(item_repository.find_by_id(1)).to eq item 
    end
  end
end
