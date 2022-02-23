require 'rspec'
require 'csv'
require 'bigdecimal'
require './lib/item'

RSpec.describe Item do
  before (:each) do
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

  it "exists" do
    expect(@i).to be_an_instance_of(Item)
  end

  it "returns the integer id of the item" do
    expect(@i.id).to eq(1)
  end

  it "returns the name of the item" do
    expect(@i.name).to eq("Pencil")
  end

  it "returns the description of the item" do
    expect(@i.description).to eq("You can use it to write things")
  end

  it "returns the price of the item formatted as a BigDecimal" do
    expect(@i.unit_price).to eq(BigDecimal(10.99,4))
  end

  it "returns a Time instance for the date the item was first created" do
    expect(@i.created_at).to eq(@i.item_info[:created_at])
  end

  it "returns a Time instance for the date the item was last modified" do
    expect(@i.updated_at).to eq(@i.item_info[:updated_at])
  end

  it "returns the integer merchant id of the item" do
    expect(@i.merchant_id).to eq(2)
  end

end
