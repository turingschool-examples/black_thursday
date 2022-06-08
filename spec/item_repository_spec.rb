require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe ItemRepository do
  let!(:sales_engine) {SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
  })}
  let!(:item_repository) {sales_engine.items}
  let!(:time) {Time.now}

  it "exists" do
    expect(item_repository).to be_instance_of ItemRepository
  end

  it 'returns array of all item instances' do
    expect(item_repository.all).to be_instance_of(Array)
  end

  it 'returns array of all item instances' do
    expect(item_repository.all.count).to be > 20
  end

  it 'returns item instance by ID' do
    expect(item_repository.find_by_id(263438579).name).to eq("Air Jordan Coloring Book")
  end

  it 'returns item instance by name' do
    expect(item_repository.find_by_name("Air Jordan Coloring Book").id).to eq(263438579)
  end

  it 'returns item instance by name, case insensitive' do
    expect(item_repository.find_by_name("Air JORDAN Coloring BoOK").id).to eq(263438579)
  end

  it 'returns item instance by name, ignoring leading/trailing spaces' do
    expect(item_repository.find_by_name("   Air JORDAN Coloring BoOK   ").id).to eq(263438579)
  end

  it 'returns all items with a specified description' do
    expect(item_repository.find_all_with_description("coffee")).to be_instance_of(Array)
    expect(item_repository.find_all_with_description("coffee").count).to eq(8)
  end

  it 'returns all items with a specified price' do
    expect(item_repository.find_all_by_price(150.00)).to be_instance_of(Array)
    expect(item_repository.find_all_by_price(150.00).count).to eq(1)
  end

  it 'returns all items in specified price range' do
    expect(item_repository.find_all_by_price_in_range(5,40)).to be_instance_of(Array)
    expect(item_repository.find_all_by_price_in_range(5,40).count).to eq(1)
  end

  it 'returns all items with specified merchant ID' do
    expect(item_repository.find_all_by_merchant_id(12334185)).to be_instance_of(Array)
    expect(item_repository.find_all_by_merchant_id(12334185).count).to eq(6)
  end

  it 'returns max item id' do
    expect(item_repository.max_id).to eq(263567474)
  end

  it 'can create new item instances' do
    expect(item_repository.max_id).to eq(263567474)
    item_repository.create({
      :id          => 0,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    expect(item_repository.max_id).to eq(263567475)
    expect(item_repository.find_by_name("Pencil").id).to eq(263567475)
  end

  it 'can update item instances' do
    item_repository.create({
      :id          => 0,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
      })
    expect(item_repository.find_by_id(263567475).name).to eq("Pencil")
    expect(item_repository.find_by_id(263567475).description).to eq("You can use it to write things")
    # expect(item_repository.find_by_id(263567475).unit_price.to_f).to eq(10.99)

    item_repository.update(263567475, {
      :name        => "Pen",
      :description => "Make your mark",
      :unit_price  => BigDecimal(14.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    expect(item_repository.find_by_id(263567475).name).to eq("Pen")
    expect(item_repository.find_by_id(263567475).description).to eq("Make your mark")
    # expect(item_repository.find_by_id(263567475).unit_price.to_f).to eq(14.99)
    expect(item_repository.find_by_id(263567475).updated_at).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end

  it 'can delete item instances' do
    expect(item_repository.all.count).to eq(1367)
    itemrepository = double()
    allow(itemrepository).to receive(:delete).and_return("Deletion complete!")

    # item_repository.delete(263438579)
    #
    # expect(item_repository.all.count).to eq(1366)
  end

end
