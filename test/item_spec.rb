require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/item"
require "./lib/merchant_repository"
require "./lib/merchant"

#You may need to add more `expect` lines to each test to make it more robust...!
RSpec.describe Item do
  before(:each) do
    @i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(1099),
      :created_at  => Time.now.round,
      :updated_at  => Time.now.round,
      :merchant_id => 2
      })

  end
  it "exists" do

      expect(@i).to be_a(Item)
  end

  it 'has an id' do
    expect(@i.id).to be_a(Integer)
    expect(@i.id).to eq(1)
  end

  it 'has a name' do
    expect(@i.name).to be_a(String)
    expect(@i.name).to eq("Pencil")
  end

  it 'has a description' do
    expect(@i.description).to be_a(String)
    expect(@i.description).to eq("You can use it to write things")
  end

  it 'has a unit_price' do
    expect(@i.unit_price).to be_a(BigDecimal)
    expect(@i.unit_price).to eq(10.99)
  end

  it 'has a merchant_id' do
    expect(@i.merchant_id).to be_a(Integer)
    expect(@i.merchant_id).to eq(2)
  end

  it 'has a created_at time saved' do
    expect(@i.created_at).to be_a(Time)
    expect(@i.created_at).to eq(Time.now.round)
  end

  it 'has a updated_at time saved' do
    expect(@i.updated_at).to be_a(Time)
    expect(@i.updated_at).to eq(Time.now.round)
  end

  it 'returns unit_price_to_dollars' do
    expect(@i.unit_price_to_dollars).to be_a(Float)
    expect(@i.unit_price_to_dollars).to eq(10.99)
  end

end
