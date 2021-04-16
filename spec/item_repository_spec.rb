# frozen_string_literal: true

require 'rspec'
require 'bigdecimal'
require './lib/item'
require './lib/item_repository'
require './lib/file_io'
require './data/mock_data'

describe ItemRepository do
  describe '#initialize' do
    it 'exists' do
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(MockData.items_as_hashes)
      item_repository = ItemRepository.new('fake.csv')

      expect(item_repository).is_a? ItemRepository
    end

    it 'has an items array' do
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(MockData.items_as_hashes)
      item_repository = ItemRepository.new('fake.csv')

      expect(item_repository.items).is_a? Array
    end
  end

  describe '#all' do
    it 'returns a list of all items' do
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(MockData.items_as_hashes)
      item_repository = ItemRepository.new('fake.csv')

      expect(item_repository.all.length).to eq 10
      expect(item_repository.all).is_a? Array
    end
  end

  describe '#find_by_id' do
    it 'returns nil if no item has the specified id' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      expect(item_repository.find_by_id(500)).to eq nil
    end

    it 'returns the item with the specified id' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      expected = item_repository.items.first
      expect(item_repository.find_by_id(0)).to eq expected
    end
  end

  describe '#find_by_name' do
    it 'returns nil if no item has name specified' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      expect(item_repository.find_by_name('Name')).to eq nil
    end

    it 'returns the item with the specified name' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      expected = item_repository.items.first
      expect(item_repository.find_by_name('Item 0')).to eq expected
    end
  end

  describe '#find_all_with_description' do
    it 'returns empty array if description does not match' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      expect(item_repository.find_all_with_description('cooking')).to eq []
    end

    it 'returns array of items with matching descriptions' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      expect(item_repository.find_all_with_description('Item Description').length).to eq 10
    end
  end

  describe '#find_all_by_price' do
    it 'returns an empty array if no items match price' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      expect(item_repository.find_all_by_price(5.99)).to eq []
    end

    it 'returns array of items that match specified price' do
      details = MockData.items_as_hashes(unit_price: 10.99)
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      expect(item_repository.find_all_by_price(10.99).length).to eq 10
    end
  end

  describe '#find_all_by_price_in_range(range)' do
    it 'returns empty array if no items in price range' do
      details = MockData.items_as_hashes(unit_price: 10)
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      expect(item_repository.find_all_by_price_in_range(15..25)).to eq []
    end

    it 'returns empty array if no items in price range' do
      details = MockData.items_as_hashes(unit_price: 10.88)
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      expect(item_repository.find_all_by_price_in_range(10..25).length).to eq 10
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'returns an empty array if no items with merchant_id' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      expect(item_repository.find_all_by_merchant_id(65)).to eq []
    end

    it 'returns all items with merchant_id' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      expect(item_repository.find_all_by_merchant_id(1).length).to eq 5
    end
  end

  describe '#create' do
    it 'creates an Item class object' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      new_item = {
        id: nil,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }
      expect(item_repository.create(new_item)).is_a? Item
    end

    it 'creates an Item with a new id' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      new_item = {
        id: nil,
        name: 'Pen',
        description: 'Writes with ink',
        unit_price: BigDecimal(12.99, 4),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }
      new_items = item_repository.create(new_item)

      expect(new_items.last.id).to eq 10
      expect(item_repository.items.length).to eq 11
    end
  end

  describe '#update' do
    it 'updates the item with new attributes' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')
      new_item = {
        id: nil,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 2
      }

      item_repository.create(new_item)

      attributes = {
        name: 'Pen',
        description: 'Writes with ink',
        unit_price: BigDecimal(12.99, 4)
      }

      item_repository.update(10, attributes)

      expected = item_repository.find_by_id(10)
      expect(expected.name).to eq 'Pen'
      expect(expected.description).to eq 'Writes with ink'
      expect(expected.unit_price).to eq BigDecimal(12.99, 4)
    end

    it 'updates the item with new time' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')
      new_item = {
        id: nil,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.new(2021, 0o1, 0o2),
        merchant_id: 2
      }
      item_repository.create(new_item)

      attributes = {
        name: 'Pen',
        description: 'Writes with ink',
        unit_price: BigDecimal(12.99, 4)
      }
      item_repository.update(10, attributes)
      item = item_repository.find_by_id(10)

      expect(item.updated_at).is_a? Time
      expect(item.updated_at).not_to eq Time.new(2021, 0o1, 0o2)
    end
  end

  describe '#delete' do
    it 'deletes the object at specified id' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      new_item = {
        id: nil,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.new(2021, 0o1, 0o2),
        merchant_id: 2
      }
      item_repository.create(new_item)

      expect(item_repository.items.length).to eq 11

      item_repository.delete(10)

      expect(item_repository.items.length).to eq 10
    end

    it 'does not delete anything if no item at id' do
      details = MockData.items_as_hashes
      mock_data = MockData.items_as_mocks(details) { self }
      allow_any_instance_of(ItemRepository).to receive(:create_items).and_return(mock_data)
      item_repository = ItemRepository.new('fake.csv')

      new_item = {
        id: nil,
        name: 'Pencil',
        description: 'You can use it to write things',
        unit_price: BigDecimal(10.99, 4),
        created_at: Time.now,
        updated_at: Time.new(2021, 0o1, 0o2),
        merchant_id: 2
      }
      item_repository.create(new_item)

      expect(item_repository.items.length).to eq 11

      item_repository.delete(24)

      expect(item_repository.items.length).to eq 11
    end
  end
end
