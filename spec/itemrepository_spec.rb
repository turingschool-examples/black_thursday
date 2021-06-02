require 'SimpleCov'
SimpleCov.start

require_relative '../lib/itemrepository'
require_relative '../lib/item'

RSpec.describe ItemRepository do
  it 'exists' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    i = Item.new(data)
    i2 = Item.new(data)
    ir = ItemRepository.new([i, i2])

    expect(ir).to be_an_instance_of(ItemRepository)
  end

  it 'can create item objects' do
    ir = ItemRepository.new([])
    ir.create_items("./data/items.csv")

    expect(ir.all[0]).to be_an_instance_of(Item)
  end

  it 'Returns a list of items' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    i = Item.new(data)
    i2 = Item.new(data)
    ir = ItemRepository.new([i, i2])

    expect(ir.all).to eq([i, i2])
  end

  it 'Can find item by ID' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    data2 = {
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(12.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    i = Item.new(data)
    i2 = Item.new(data2)
    ir = ItemRepository.new([i, i2])

    expect(ir.find_by_id(1)).to eq(i)
    expect(ir.find_by_id(2)).to eq(i2)
  end

  it 'Finds an item by name' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    data2 = {
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(12.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    i = Item.new(data)
    i2 = Item.new(data2)
    ir = ItemRepository.new([i, i2])

    expect(ir.find_by_name('Pen')).to eq(i2)
    expect(ir.find_by_name('Pencil')).to eq(i)
  end

  it 'Finds item by description' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    data2 = {
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(12.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    i = Item.new(data)
    i2 = Item.new(data2)
    ir = ItemRepository.new([i, i2])

    expect(ir.find_all_with_description("You can use it to write things")).to eq([i, i2])
    expect(ir.find_all_with_description("Help me")).to eq([])
  end

  it 'Finds all instances of an item by price' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    data2 = {
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(12.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    data3 = {
      :id          => 3,
      :name        => "Marker",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(12.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 4
    }
    i = Item.new(data)
    i2 = Item.new(data2)
    i3 = Item.new(data3)
    ir = ItemRepository.new([i, i2, i3])

    expect(ir.find_all_by_price(10.99)).to eq([i])
    expect(ir.find_all_by_price(12.99)).to eq([i2, i3])
    expect(ir.find_all_by_price(11.99)).to eq([])
  end

  it 'Can find all instances in price range' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    data2 = {
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(12.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    data3 = {
      :id          => 3,
      :name        => "Fountain Pen",
      :description => "You can write fancy things",
      :unit_price  => BigDecimal(20.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 4
    }
    i = Item.new(data)
    i2 = Item.new(data2)
    i3 = Item.new(data3)
    ir = ItemRepository.new([i, i2, i3])

    expect(ir.find_all_by_price_in_range(8..15)).to eq([i, i2])
    expect(ir.find_all_by_price_in_range(0..7)).to eq([])
    expect(ir.find_all_by_price_in_range(16.00..25.00)).to eq([i3])
  end

  it 'Finds all instances based on merchant ID' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    data2 = {
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(12.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    data3 = {
      :id          => 3,
      :name        => "Fountain Pen",
      :description => "You can write fancy things",
      :unit_price  => BigDecimal(20.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    i = Item.new(data)
    i2 = Item.new(data2)
    i3 = Item.new(data3)
    ir = ItemRepository.new([i, i2, i3])

    expect(ir.find_all_by_merchant_id(3)).to eq([i2,i3])
    expect(ir.find_all_by_merchant_id(7)).to eq([])
    expect(ir.find_all_by_merchant_id(2)).to eq([i])
  end

  it 'Creates a new instance with attributes' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    data2 = {
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(12.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    data3 = {
      :id          => 3,
      :name        => "Fountain Pen",
      :description => "You can write fancy things",
      :unit_price  => BigDecimal(20.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    data4 = {
      :name        => "Fountain Pen",
      :description => "You can write fancy things",
      :unit_price  => 20.99,
      :merchant_id => 3
    }
    i = Item.new(data)
    i2 = Item.new(data2)
    i3 = Item.new(data3)
    ir = ItemRepository.new([i, i2, i3])
    i4 = ir.create(data4)

    expect(ir.all).to eq([i, i2, i3, i4])
    expect(i4.id).to eq(4)
  end

  it 'Finds item by ID and update attributes' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    data2 = {
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(12.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    data3 = {
      :id          => 3,
      :name        => "Fountain Pen",
      :description => "You can write fancy things",
      :unit_price  => BigDecimal(20.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    data4 = {
      :name        => "Gold Fountain Pen",
      :description => "You can write REALLY fancy things",
      :unit_price  => 12009,
    }
    i = Item.new(data)
    i2 = Item.new(data2)
    i3 = Item.new(data3)
    ir = ItemRepository.new([i, i2, i3])

  ir.update(3, data4)
  expect(i3.name).to eq("Gold Fountain Pen")
  expect(i3.description).to eq("You can write REALLY fancy things")
  expect(i3.unit_price_to_dollars).to eq(12009)
  end

  it 'Finds and deletes item by ID' do
    data = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    data2 = {
      :id          => 2,
      :name        => "Pen",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(12.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    i = Item.new(data)
    i2 = Item.new(data2)
    ir = ItemRepository.new([i, i2])

    ir.delete(2)
    expect(ir.all).to eq([i])
  end
end
