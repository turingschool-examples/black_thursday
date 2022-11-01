require './lib/item'
require './lib/item_repository'

RSpec.describe ItemRepository do
let!(:time_now) {Time.now}
let!(:item_repository) {ItemRepository.new([item_1, item_2, item_3])}
let!(:item_1) {Item.new(
  {
:id          => 1,
:name        => "Pencil",
:description => "You can use it to write things",
:unit_price  => BigDecimal(10.99,4),
:created_at  => time_now,
:updated_at  => time_now,
:merchant_id => 2
}
)}

let!(:item_2) {Item.new(
  {
:id          => 2,
:name        => "Notebook",
:description => "You can use it to write in",
:unit_price  => BigDecimal(8.99,4),
:created_at  => time_now,
:updated_at  => time_now,
:merchant_id => 2
}
)}

let!(:item_3) {Item.new(
  {
:id          => 3,
:name        => "Pencil crayons",
:description => "You can use it to color",
:unit_price  => BigDecimal(12.00,4),
:created_at  => time_now,
:updated_at  => time_now,
:merchant_id => 2
}
)}

  it 'is an item repository class' do
    expect(item_repository).to be_a(ItemRepository)
  end

  it 'returns all item instances' do
    expect(item_repository.all).to eq([item_1, item_2, item_3])
  end

  it 'can find item by id' do
    expect(item_repository.find_by_id(2)).to eq(item_2)
    expect(item_repository.find_by_id(5)).to eq(nil)
  end

  xit 'can find item by name' do
    expect(item_repository.find_by_name("Pencil Crayons")).to eq(item_3)
    expect(item_repository.find_by_name("Textbook")).to eq(nil)
  end

  xit 'can find all items with included description' do
    expect(item_repository.find_all_with_description("You can use it to write things")).to eq([item_1])
    expect(item_repository.find_all_with_description("You can erase things")).to eq([])
  end

  xit 'can find all items by a given price' do
    expect(item_repository.find_all_by_price(8.99)).to eq(item_2)
    expect(item_repository.find_all_by_price(5.00)).to eq([])
  end

  xit 'can find all items by price, within a range' do
    expect(item_repository.find_all_by_price_in_range(8.00..11.00)).to eq([item_1, item_2])
    expect(item_repository.find_all_by_price_in_range(1.00..3.00)).to eq([])
  end

  xit 'can find all items that are a merchants (id)' do
    expect(item_repository.find_all_by_merchant_id(2)).to eq([item_1, item_2, item_3])
    expect(item_repository.find_all_by_merchant_id(5)).to eq([])
  end

  xit 'can create a new item by supplying the attributes' do
    expect(item_repository.create(item_4)).to eq(item_4)
  end

  xit 'can update an item by the id, giving new attributes' do
    expect(item_repository.update(1, name: "Mechanical Pencil")).to eq(item_1.name)
    expect(item_repository.update(1, description: "You can use it to write things down")).to eq(item_1.description)
    expect(item_repository.update(1, unit_price: 9.99)).to eq(item_1.unit_price)
    expect(item_repository.updated_at).to eq(time_now)
    expect(item_repository.updated_at).to not_eq(created_at)
  end

  xit 'can delete an item by supplied id' do
    expect(item_repository.delete(2)).to eq(item.all)
  end
end