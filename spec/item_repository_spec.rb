require 'rspec'
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


end
