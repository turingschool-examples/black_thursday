require './lib/item_repository'
require './lib/item'

RSpec.describe ItemRepository do
  let(:ir) { ItemRepository.new }
  
  describe '#initialize' do
    it 'exists' do
      expect(ir).to be_a(ItemRepository)
    end
    
    it 'starts with an empty array' do
      expect(ir.all).to eq([])
    end
  end
end