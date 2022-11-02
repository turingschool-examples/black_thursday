require "./lib/item_repository"
require './lib/item'
require './lib/sales_engine'
require "pry"

RSpec.describe ItemRepository do
  before :each do
    se = SalesEngine.from_csv({items: './data/items.csv', merchants: './data/merchants.csv'})
    @ir = se.items
  end

  it 'exists' do
    expect(@ir).to be_a(ItemRepository)
  end

  it 'returns an array of all known Item instances' do
    expect(@ir.items).to be_a(Array)
  end

  it 'finds by id, returns nil otherwise' do
    expect(@ir.find_by_id(263395237)).to eq(@ir.items.first)
    expect(@ir.find_by_id(263567474)).to eq(@ir.items.last)
    expect(@ir.find_by_id(263395617)).to eq(@ir.items[1])
    expect(@ir.find_by_id(999999999)).to eq(nil)
    expect(@ir.find_by_id(263395237)).to be_a(Item)
  end

  it 'finds by name (case insensitive), returns nil otherwise' do
    expect(@ir.find_by_name("510+ RealPush Icon Set")).to eq(@ir.items.first)
    expect(@ir.find_by_name("510+ reAlPUSh IcoN seT")).to eq(@ir.items.first)
    expect(@ir.find_by_name("Glitter scrabble frames")).to eq(@ir.items[1])
    expect(@ir.find_by_name("GLITter SCRAbbLe fraMES")).to eq(@ir.items[1])
    expect(@ir.find_by_name("XXXXXXXXXX")).to eq(nil)
    expect(@ir.find_by_name("510+ RealPush Icon Set")).to be_a(Item)
  end

  it 'finds all instances given a description (case insensitive), returns empty array otherwise' do
    item1 = @ir.find_all_with_description("Disney")
    item2 = @ir.find_all_with_description("diSNeY")
    item3 = @ir.find_all_with_description("XXXXXXXXX")

    expect(item1.count).to eq(5)
    expect(item2.count).to eq(5)
    expect(item1.first.id).to eq(263395721)
    expect(item2.first.id).to eq(263395721)
    expect(item3).to eq([])
    expect(item1).to be_a(Array)
    expect(item2).to be_a(Array)
  end

  it 'finds items with exact price given, returns empty array otherwise' do
    item1 = @ir.find_all_by_price(1300)
    item2 = @ir.find_all_by_price(1350)
    item3 = @ir.find_all_by_price(9999)

    expect(item1.count).to eq(8)
    expect(item2.first.id).to eq(263395721)
    expect(item3).to eq([])
    expect(item1).to be_a(Array)
  end

  it 'finds item within a given price range, returns empty array otherwise' do
    item1 = @ir.find_all_by_price_in_range(1300..1360)
    item2 = @ir.find_all_by_price_in_range(1..5)

    expect(item1.count).to eq(9)
    expect(item1.first.id).to eq(263395617)
    expect(item1[7].id).to eq(263546142)
    expect(item2).to eq([])
    expect(item1).to be_a(Array)
  end

  it 'finds item with matching merchant ID, returns empty array otherwise' do
    item1 = @ir.find_all_by_merchant_id(12334105)
    item2 = @ir.find_all_by_merchant_id(11111111)

    expect(item1.count).to eq(3)
    expect(item1.first.id).to eq(263396209)
    expect(item2).to eq([])
    expect(item1).to be_a(Array)
  end

  it 'can create a new item' do
    items_pre = @ir.items.length
    attributes = {
      name: "Colorado Sweater",
      description: "Perfect sweater for Colorado weather",
      unit_price: 50,
      merchant_id: 3487283
    }
    @ir.create(attributes)
    expect(@ir.items.last.id).to eq(263567474 + 1)
    expect(items_pre).to eq(@ir.items.length - 1)
  end

  it 'can update an item' do
    attributes = {
      name: "Colorado Sweater",
      description: "Perfect sweater for Colorado weather",
      unit_price: 50,
      merchant_id: 3487283
    }
    @ir.update(263395617, attributes)
    expect(@ir.find_by_id(263395617).name).to eq("Colorado Sweater")
  end

  it 'can delete an item' do
    @ir.delete(263395617)
    expect(@ir.find_by_id(263395617)).to eq(nil)
  end

  it 'can find an item by name' do
    expect(@ir.find_all_by_name("Disney scrabble frames")[0].id).to eq(263395721)
  end
end