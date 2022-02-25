require 'rspec'
require './lib/items_repository'

describe ItemsRepository do
  before(:each) do
    @ir = ItemsRepository.new("./data/items.csv")
  end

  it "exists" do
    expect(@ir).to be_an_instance_of(ItemsRepository)
  end

  it 'lists all items' do
    expect(@ir.all).to eq(@ir.repository)
  end

  it 'can find an item by the id' do
    item = @ir.find_by_id("263395237")
    expect(item.name).to eq("510+ RealPush Icon Set")
    expect(item.unit_price).to eq("1200")
  end

  it 'can find an item by the name' do
    item = @ir.find_by_name("510+ RealPush Icon Set")
    expect(item.id).to eq("263395237")
    expect(item.unit_price).to eq("1200")
  end

  it 'can find all items with specific description' do
    item = @ir.find_all_with_description("Acrylique sur toile exécutée en 2011")

    expect(item.count).to eq(3)
  end

  it 'can find all items with specific price' do
    item = @ir.find_all_by_price("50000")

    expect(item.count).to eq(11)
  end

  it 'can find all items within price range' do
    item = @ir.find_all_by_price_in_range("40000", "50000")

    expect(item.count).to eq(26)
    expect(item[0].id).to eq('263396517')
  end

  it 'can find all items with specific merchant_id' do
    item = @ir.find_all_by_merchant_id("12334195")
    expect(item.count).to eq(20)
    expect(item[0].unit_price).to eq('14900')
  end
end
