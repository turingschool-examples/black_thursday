require './lib/item'
require 'BigDecimal'

RSpec.describe Item do
  before :each do
    @i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })
  end

  it 'exists' do
    expect(@i).to be_a(Item)
  end

  it 'converts unit price to dollars' do
    expect(@i.unit_price_to_dollars).to eq(10.99)
  end

  it "has an id" do
    expect(@i.id).to eq(1)
  end

  it "has a name" do
    expect(@i.name).to eq("Pencil")
  end

  it "has a description" do
    expect(@i.description).to eq("You can use it to write things")
  end

  it "has a unit_price" do
    expect(@i.unit_price).to eq(10.99)
  end

  it "has created_at" do
    expect(@i.created_at).to be_a(Time)
  end

  it "has updated_at" do
    expect(@i.updated_at).to be_a(Time)
  end

  it "has a merchant_id" do
    expect(@i.merchant_id).to eq(2)
  end
end
