require './lib/item'
require './lib/item_repository'

RSpec.describe ItemRepository do
  it 'exists' do
    item_repo = ItemRepository.new
    expect(item_repo).to be_instance_of(ItemRepository)

  end
    it 'holds Item instances' do

    end

    it 'searches Item instances' do
    end

    it 'returns all known item instances' do
  id     item_repo = ItemRepository.new

        expect(item_repo.all).to eq([])

        i = Item.new({
            id: 1,
            name: 'Pencil',
            description: 'You can use it to write things',
            unit_price: BigDecimal(10.99, 4),
            created_at: Time.now,
            updated_at: Time.now,
            merchant_id: 2
          })
          expect(item_repo.all[0]).to be_instance_of(Item)
    end
end
