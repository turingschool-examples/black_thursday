require 'rspec'
require './lib/item_repository'


describe ItemRepository do

  it 'exists' do
    item_repo1 = ItemRepository.new

    expect(item_repo1).to be_a ItemRepository
  end

    describe 'all' do
      it 'returns all items' do
      end
    end

    describe 'find_by_id(id)' do
      it 'returns items with matching id' do
      end
    end

    describe 'find_by_name(name)' do
      it 'returns items with matching names' do
      end
    end

    describe 'find_all_by_price(price)' do
      it 'returns items with matching prices' do
      end
    end

    describe 'find_all_by_price_in_range(range)' do
      it 'returns items within matching prices given a range' do
      end
    end

    describe 'find_all_by_merchant_id(merchant_id)' do
      it 'returns items with matching merchant ids' do
      end
    end

    describe 'create(attributes)' do
      it 'creates a new item with given attributes' do
      end
    end

    describe 'update(id, attributes)' do
      it 'updates the item with given ids attributes' do
      end
    end

    describe 'delete(id)' do
      it 'deletes the item with the given id' do
      end
    end
  end
