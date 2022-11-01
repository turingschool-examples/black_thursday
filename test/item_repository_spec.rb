require './lib/item'
require './lib/item_repository'

RSpec.describe ItemRepository do
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
    expect(ItemRepository.all[0]).to be_instance_of(Item)
  end

  it 'finds by ID' do
    i = Item.new({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(ItemRepository.find_by_id(1)).to be_instance_of(Item)
    expect(ItemRepository.find_by_id(45)).to eq(nil)
  end

  it 'finds by name' do
    i = Item.new({
                   id: 1,
                   name: 'Pencil',
                   description: 'You can use it to write things',
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now,
                   merchant_id: 2
                 })
    expect(ItemRepository.find_by_name('Pencil')).to be_instance_of(Item)
    expect(ItemRepository.find_by_name('Marker')).to eq(nil)
  end


end
