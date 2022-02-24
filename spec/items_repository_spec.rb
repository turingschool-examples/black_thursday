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

  it 'can find an item by description' do
    item = @ir.find_all_with_description("Acrylique sur toile exécutée en 2011")

    expect(item.count).to eq(3)
    # expect(item).to eq("50000")
  end
end
