# frozen_string_literal: true

require 'rspec'
require 'bigdecimal'
require './lib/item'
require './lib/item_repository'
require './lib/file_io'

describe ItemRepository do
  describe '#initialize' do
    it 'exists' do 
      filename = './data/items.csv'
      item_repository = ItemRepository.new(filename)

      expect(item_repository).is_a? ItemRepository 
    end

    it 'has an items array' do
      filename = './data/items.csv'
      item_repository = ItemRepository.new(filename)

      expect(item_repository.items).is_a? Array
    end
  end

  describe '#all' do
    it 'returns a list of all items' do
      filename = "./data/items.csv"
      # allow_any_instance_of(ItemRepository).to receive(:create_items).and_return {MockData.get_mock_items}
# require 'pry'; binding.pry 
      item_repository = ItemRepository.new(filename)

      expect(item_repository.all.length).to eq 1367
      expect(item_repository.all).is_a? Array
    end
  end

  describe '#find_by_id' do
    it 'returns nil if no item has the specified id' do
      filename = './data/items.csv'
      item_repository = ItemRepository.new(filename)

      expect(item_repository.find_by_id(2)).to eq nil
    end

    it 'returns the item with the specified id' do
      filename = './data/items.csv'
      item_repository = ItemRepository.new(filename)

      expected = item_repository.items.first
      expect(item_repository.find_by_id(263395237)).to eq expected
    end
  end

  describe '#find_by_name' do
    it 'returns nil if no item has name specified' do
      filename = './data/items.csv'
      item_repository = ItemRepository.new(filename)

      expect(item_repository.find_by_name('Name')).to eq nil
    end

    it 'returns the item with the specified name' do
      filename = './data/items.csv'
      item_repository = ItemRepository.new(filename)

      expected = item_repository.items.first
      expect(item_repository.find_by_name('510+ RealPush Icon Set')).to eq expected
    end
  end

  # describe '#find_all_with_description' do
  #   it 'returns empty array if description does not match' do
  #     details = {
  #       id: 1,
  #       name: 'Pencil',
  #       description: 'You can use it to write things',
  #       unit_price: BigDecimal(10.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     item = Item.new(details)
  #     item_repository = ItemRepository.new([item])

  #     expect(item_repository.find_all_with_description('cooking')).to eq []
  #   end

  #   it 'returns array of items with matching descriptions' do
  #     details1 = {
  #       id: 1,
  #       name: 'Pencil',
  #       description: 'You can use it to write things',
  #       unit_price: BigDecimal(10.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     details2 = {
  #       id: 2,
  #       name: 'Pen',
  #       description: 'Writes with ink',
  #       unit_price: BigDecimal(12.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     item1 = Item.new(details1)
  #     item2 = Item.new(details2)
  #     items = [item1, item2]
  #     item_repository = ItemRepository.new(items)

  #     expect(item_repository.find_all_with_description('write')).to eq items
  #   end
  # end

  # describe '#find_all_by_price' do
  #   it 'returns an empty array if no items match price' do
  #     details = {
  #       id: 1,
  #       name: 'Pencil',
  #       description: 'You can use it to write things',
  #       unit_price: BigDecimal(10.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     item = Item.new(details)
  #     item_repository = ItemRepository.new([item])

  #     expect(item_repository.find_all_by_price(5.99)).to eq []
  #   end

  #   it 'returns array of items that match specified price' do
  #     details1 = {
  #       id: 1,
  #       name: 'Pencil',
  #       description: 'You can use it to write things',
  #       unit_price: BigDecimal(10.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     details2 = {
  #       id: 2,
  #       name: 'Pen',
  #       description: 'Writes with ink',
  #       unit_price: BigDecimal(12.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     item1 = Item.new(details1)
  #     item2 = Item.new(details2)
  #     items = [item1, item2]
  #     item_repository = ItemRepository.new(items)

  #     expect(item_repository.find_all_by_price(10.99)).to eq [item1]
  #   end
  # end

  # describe '#find_all_by_price_in_range(range)' do
  #   it 'returns empty array if no items in price range' do
  #     details1 = {
  #       id: 1,
  #       name: 'Pencil',
  #       description: 'You can use it to write things',
  #       unit_price: BigDecimal(10.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     details2 = {
  #       id: 2,
  #       name: 'Pen',
  #       description: 'Writes with ink',
  #       unit_price: BigDecimal(12.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     item1 = Item.new(details1)
  #     item2 = Item.new(details2)
  #     items = [item1, item2]
  #     item_repository = ItemRepository.new(items)

  #     expect(item_repository.find_all_by_price_in_range(15..25)).to eq []
  #   end

  #   it 'returns empty array if no items in price range' do
  #     details1 = {
  #       id: 1,
  #       name: 'Pencil',
  #       description: 'You can use it to write things',
  #       unit_price: BigDecimal(10.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     details2 = {
  #       id: 2,
  #       name: 'Pen',
  #       description: 'Writes with ink',
  #       unit_price: BigDecimal(12.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     item1 = Item.new(details1)
  #     item2 = Item.new(details2)
  #     items = [item1, item2]
  #     item_repository = ItemRepository.new(items)

  #     expect(item_repository.find_all_by_price_in_range(10..25)).to eq items
  #   end
  # end

  # describe '#find_all_by_merchant_id' do
  #   it 'returns an empty array if no items with merchant_id' do
  #     details1 = {
  #       id: 1,
  #       name: 'Pencil',
  #       description: 'You can use it to write things',
  #       unit_price: BigDecimal(10.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     details2 = {
  #       id: 2,
  #       name: 'Pen',
  #       description: 'Writes with ink',
  #       unit_price: BigDecimal(12.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     item1 = Item.new(details1)
  #     item2 = Item.new(details2)
  #     items = [item1, item2]
  #     item_repository = ItemRepository.new(items)

  #     expect(item_repository.find_all_by_merchant_id(3)).to eq []
  #   end

  #   it 'returns all items with merchant_id' do
  #     details1 = {
  #       id: 1,
  #       name: 'Pencil',
  #       description: 'You can use it to write things',
  #       unit_price: BigDecimal(10.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     details2 = {
  #       id: 2,
  #       name: 'Pen',
  #       description: 'Writes with ink',
  #       unit_price: BigDecimal(12.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     item1 = Item.new(details1)
  #     item2 = Item.new(details2)
  #     items = [item1, item2]
  #     item_repository = ItemRepository.new(items)

  #     expect(item_repository.find_all_by_merchant_id(2)).to eq items
  #   end
  # end

  describe '#create' do
    it 'creates an Item class object' do
      filename = "./data/items.csv"
      item_repository = ItemRepository.new(filename)
      details = {
        id: nil,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }
      expect(item_repository.create(details)).is_a? Item
    end

    it 'creates an Item with a new id' do
      filename = "./data/items.csv"
      item_repository = ItemRepository.new(filename)

      details = {
        id: nil,
        name: 'Pen',
        description: 'Writes with ink',
        unit_price: BigDecimal(12.99, 4),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }
      new_items = item_repository.create(details)

      expect(new_items.last.id).to eq 263567475
      expect(item_repository.items.length).to eq 1368
    end
  end

  describe '#update_id_and_attributes' do
    it 'updates the item with new attributes' do
      filename = "./data/items.csv"
      item_repository = ItemRepository.new(filename)

      attributes = {
        name: 'Pen',
        description: 'Writes with ink',
        unit_price: BigDecimal(12.99, 4)
      }
      item_repository.update(263567474, attributes)
      
      expected = item_repository.find_by_id(263567474)
      expect(expected.name).to eq 'Pen'
      expect(expected.description).to eq 'Writes with ink'
      expect(expected.unit_price).to eq BigDecimal(12.99, 4)
    end

  #   it 'updates the item with new time' do
  #     details1 = {
  #       id: 1,
  #       name: 'Pencil',
  #       description: 'You can use it to write things',
  #       unit_price: BigDecimal(10.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.new(2021, 0o1, 0o2),
  #       merchant_id: 2
  #     }
  #     item1 = Item.new(details1)
  #     item_repository = ItemRepository.new([item1])

  #     attributes = {
  #       name: 'Pen',
  #       description: 'Writes with ink',
  #       unit_price: BigDecimal(12.99, 4)
  #     }
  #     item_repository.update(1, attributes)

  #     expect(item1.updated_at).is_a? Time
  #     expect(item1.updated_at).not_to eq Time.new(2021, 0o1, 0o2)
  #   end
  end

  # describe '#delete' do
  #   it 'deletes the object at specified id' do
  #     details1 = {
  #       id: 1,
  #       name: 'Pencil',
  #       description: 'You can use it to write things',
  #       unit_price: BigDecimal(10.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     details2 = {
  #       id: 2,
  #       name: 'Pen',
  #       description: 'Writes with ink',
  #       unit_price: BigDecimal(12.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     item1 = Item.new(details1)
  #     item2 = Item.new(details2)
  #     items = [item1, item2]
  #     item_repository = ItemRepository.new(items)

  #     item_repository.delete(1)

  #     expect(item_repository.items).to eq [item2]
  #   end

  #   it 'does not delete anything if no item at id' do
  #     details1 = {
  #       id: 1,
  #       name: 'Pencil',
  #       description: 'You can use it to write things',
  #       unit_price: BigDecimal(10.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     details2 = {
  #       id: 2,
  #       name: 'Pen',
  #       description: 'Writes with ink',
  #       unit_price: BigDecimal(12.99, 4),
  #       created_at: Time.now,
  #       updated_at: Time.now,
  #       merchant_id: 2
  #     }
  #     item1 = Item.new(details1)
  #     item2 = Item.new(details2)
  #     items = [item1, item2]
  #     item_repository = ItemRepository.new(items)

  #     item_repository.delete(3)

  #     expect(item_repository.items).to eq [item1, item2]
  #   end
  # end
end


