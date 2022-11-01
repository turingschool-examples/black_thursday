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

        i = Item.new({
            id: 1,
            name: 'Pencil',
            description: 'You can use it to write things',
            unit_price: BigDecimal(10.99, 4),
            created_at: Time.now,
            updated_at: Time.now,
            merchant_id: 2
          })
          expect(ItemRepository.all).to eq([i])
    end
end
