require './lib/item'
require './lib/item_repository'

RSpec.describe ItemRepository do
    it 'exists' do
        ir = ItemRepository.new
        expect(ir).to be_instance_of(ItemRepository)
    end
end