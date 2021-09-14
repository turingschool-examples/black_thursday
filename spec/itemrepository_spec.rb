require 'rspec'
require './lib/item'
require './lib/itemrepository'

describe 'itemrepository' do
  describe '#initialize' do
    it 'is an instance of ItemRepository' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      expect(ir).to be_an_instance_of ItemRepository
    end
  end

  describe '#all' do
    it 'returns an array of all item instances' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      expect(ir.all).to be_an Array
    end
  end

  describe '#find_by_id' do
    it 'returns an instance of Item matching the id' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      expect(ir.find_by_id("263395617")).to be_an_instance_of Item
      expect(ir.find_by_id("263395617").id).to eq("263395617")
      expect(ir.find_by_id("263395617").name).to eq("Glitter scrabble frames")
    end
  end

  describe '#find_by_name' do
    it 'returns an instance of Item matching the name' do
      path = './data/items.csv'
      ir = ItemRepository.new(path)

      expect(ir.find_by_name("JSK Chai")).to be_an_instance_of Item
      expect(ir.find_by_name("JSK Chai").id).to eq("263549122")
      expect(ir.find_by_name("JSK Chai").name).to eq("JSK Chai")
    end
  end
end
