require 'rspec'
require './lib/item_repository'

describe ItemRepository do
  describe '#initialize' do
    it 'exists' do
      item_repository = ItemRepository.new

      expect(item_repository).is_a? ItemRepository
    end
  end
end
