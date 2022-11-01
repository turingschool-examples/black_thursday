require './lib/item'
require './lib/item_repository'

RSpec.describe ItemRepository do
#   it 'exists' do
#     # ir = ItemRepository.new
#     # expect(ir).to be_instance_of(ItemRepository)

#   end
    it 'holds Item instances' do

    end

    it 'searches Item instances' do
    end

    it 'returns all known item instances' do
        expect(ItemRepository.all).to eq([])
        
    end
end
