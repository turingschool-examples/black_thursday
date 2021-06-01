require_relative 'spec_helper'

RSpec.describe ItemRepository do
  describe 'instantiation' do
    it 'exists' do
      item_repository = ItemRepository.new("path", "engine")

      expect(item_repository).to be_a(ItemRepository)
    end
  end

  describe 'methods' do
    it 'returns an array of all known item instances' do
      item_repository = ItemRepository.new("path", "engine")

      expect(ItemRepository.all).to eq([])
    end
  end
end
