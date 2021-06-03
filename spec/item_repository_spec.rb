require 'SimpleCov'
SimpleCov.start

require_relative '../lib/item_repository'
require_relative '../lib/item'

RSpec.describe ItemRepository do
  it 'exists' do
    ir = ItemRepository.new("./spec/fixture_files/item_fixture.csv")

    expect(ir).to be_an_instance_of(ItemRepository)
  end

  it 'can create item objects' do
    ir = ItemRepository.new("./spec/fixture_files/item_fixture.csv")

    expect(ir.all[0]).to be_an_instance_of(Item)
  end

  it 'Returns a list of items' do
    ir = ItemRepository.new("./spec/fixture_files/item_fixture.csv")

    expect(ir.all.count).to eq(4)
  end

  it 'Can find item by ID' do
    ir = ItemRepository.new("./spec/fixture_files/item_fixture.csv")
    expected = ir.find_by_id(1)
    expected2 = ir.find_by_id(2)

    expect(expected.name).to eq('Pencil')
    expect(expected2.name).to eq('Pen')
  end

  it 'Finds an item by name' do
    ir = ItemRepository.new("./spec/fixture_files/item_fixture.csv")
    expected = ir.find_by_name('Pen')
    expected2 = ir.find_by_name('Pencil')

    expect(expected.name).to eq('Pen')
    expect(expected2.name).to eq('Pencil')
  end

  it 'Finds item by description' do
    ir = ItemRepository.new("./spec/fixture_files/item_fixture.csv")
    expected = ir.find_all_with_description('You can use it to write things')
    expected2 = ir.find_all_with_description('Help me')

    expect(expected.count).to eq(3)
    expect(expected2.count).to eq(0)
  end

  it 'Finds all instances of an item by price' do
    ir = ItemRepository.new("./spec/fixture_files/item_fixture.csv")
    expected = ir.find_all_by_price(10.99)
    expected2 = ir.find_all_by_price(12.99)
    expected3 = ir.find_all_by_price(15.99)

    expect(expected.count).to eq(1)
    expect(expected2.count).to eq(2)
    expect(expected3.count).to eq(0)
  end

  it 'Can find all instances in price range' do
    ir = ItemRepository.new("./spec/fixture_files/item_fixture.csv")
    expected = ir.find_all_by_price_in_range(8..15)
    expected2 = ir.find_all_by_price_in_range(0..7)
    expected3 = ir.find_all_by_price_in_range(16.00..25.00)

    expect(expected.count).to eq(3)
    expect(expected2.count).to eq(0)
    expect(expected3.count).to eq(1)
  end

  it 'Finds all instances based on merchant ID' do
    ir = ItemRepository.new("./spec/fixture_files/item_fixture.csv")
    expected = ir.find_all_by_merchant_id(3)
    expected2 = ir.find_all_by_merchant_id(7)
    expected3 = ir.find_all_by_merchant_id(4)


    expect(expected.count).to eq(1)
    expect(expected2.count).to eq(0)
    expect(expected3.count).to eq(2)
  end

  it 'Creates a new instance with attributes' do
    ir = ItemRepository.new("./spec/fixture_files/item_fixture.csv")
    expected = ir.create({
      :name        => "Golden Fountain Pen",
      :description => "You can write REALLY fancy things",
      :unit_price  => 12009,
      :merchant_id => 4
    })

    expect(ir.all.count).to eq(5)
    expect(expected.id).to eq(5)
  end

  it 'Finds item by ID and update attributes' do
    ir = ItemRepository.new("./spec/fixture_files/item_fixture.csv")
    data = {
      :name        => "Gold Fountain Pen",
      :description => "You can write REALLY fancy things",
      :unit_price  => 12009,
    }
    ir.update(3, data)
    expected = ir.find_by_id(3)

    expect(expected.name).to eq("Gold Fountain Pen")
    expect(expected.description).to eq("You can write REALLY fancy things")
    expect(expected.unit_price_to_dollars).to eq(12009)
  end

  it 'Finds and deletes item by ID' do
    ir = ItemRepository.new("./spec/fixture_files/item_fixture.csv")

    ir.delete(2)
    expect(ir.all.count).to eq(3)
  end
end
