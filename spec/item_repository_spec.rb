require 'rspec'
require './lib/item_repository'

describe ItemRepository do
  describe '#initialize' do
    it 'exists' do
      item_repository = ItemRepository.new

      expect(item_repository).is_a? ItemRepository
    end
  end

  describe '#generate_items' do
    it 'returns an array of all Item instances' do
      filename = './data/items.csv'
      item_repository = ItemRepository.new(filename)

      expected = []
      expect(item_repository.all).to eq expected
    end
  end
end
