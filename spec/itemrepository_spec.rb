require 'rspec'
require './lib/itemrepository'

describe 'itemrepository' do
  describe '#initialize' do
    it 'is an instance of ItemRepository' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      expect(ir).to be_an_instance_of ItemRepository
    end

    
  end
end
