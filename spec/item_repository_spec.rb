require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative 'spec_helper'
require 'pry'

RSpec.describe ItemRepository do

  before(:each) do
    se = SalesEngine.from_csv({:items=> "./data/items.csv", :merchants => "./data/merchants.csv",})
    @items = se.items
  end

  it "exist" do
    expect(@items).to be_a(ItemRepository)
  end

  it "holds #all merchant data" do
    expect(@items.all.count).to eq(1367)
  end

  it "can find by id or return nil" do
    expected = @items.find_by_id(263395237)
    expect(expected.id).to eq(263395237)
    expect(expected.name).to eq("510+ RealPush Icon Set")
    expect(@items.find_by_id('1')).to be nil
  end

  it "can find first matching item by case-insensitive name or nil" do
    name = "510+ RealPush Icon Set"
    expected = @items.find_by_name(name)
    expect(expected.name).to eq("510+ RealPush Icon Set")
    name_up = name.upcase
    expected_up = @items.find_by_name(name_up)
    expect(expected_up.id).to eq 263395237
    expect(expected_up.name).to eq name
    expect(@items.find_by_name("kk")).to be nil
  end

  it "can find all items matching a description or return nil" do
    description = "A large Yeti of sorts, casually devours a cow as the others watch numbly."
    expected = @items.find_all_with_description(description)

    expect(expected.first.description).to eq description
    expect(expected.first.id).to eq 263550472
    expect(@items.find_all_with_description("Luke's Whalesalers")).to eq []
  end

  it 'can find all items matching given price' do
    price = 25
    items_25 = @items.find_all_by_price(price)

    expect(items_25.length).to eq 79
  end

  it 'can find all items in a given range' do
    price_range = (1000.0..1500.0)
    items_1000_1500 = @items.find_all_by_price_in_range(price_range)
    items_10_15 = @items.find_all_by_price_in_range((10.0..15.0))
    expect(items_1000_1500.length).to eq 19
    expect(items_10_15.length).to eq 205
  end

  it 'can find all by merchant id' do
    merchant_id = 12334141
    item_by_merchant = @items.find_all_by_merchant_id(merchant_id)
    expect(item_by_merchant.length).to eq 1
  end

  it "creates a new item instance" do
    attributes = {
      name: "KGBeer, Co",
      description: "A smooth pale ale from the tundras of mother Russia",
      unit_price: "500.0",
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 12334141
    }
    kgbeerco = @items.create(attributes)
    expect(kgbeerco.name).to eq("KGBeer, Co")
    expect(@items.find_all_by_merchant_id(12334141).length).to eq(2)
  end

  it "updates a item name but not id" do
    attribute = {unit_price: 179.99, description: "description"}
    expected = @items.update(263395237, attribute)

    expect(expected.unit_price).to eq(179.99)
    expect(expected.description).to eq("Description")
    expect(expected.name).to be("510+ RealPush Icon Set")
  end

  xit "deletes a merchant by id" do
    @merchants_i.delete(12337412)
    expected = @merchants_i.find_by_id(12337412)
    expect(expected).to eq nil
  end

end
