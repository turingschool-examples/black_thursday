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

  xit "creates a new item" do
    turing = {name: "Turing School of Software and Design"}
    expected = @merchants_i.create(turing)
    expect(expected.name).to eq "Turing School of Software and Design"
  end

  xit "updates a merchant name but not id" do
    attribute = {name: "TSSD"}
    expected = @merchants_i.update(12337411, attribute)
    expect(expected.name).to eq "TSSD"
    expect(@merchants_i.find_by_name("Turing School of Software and Design")).to be nil
    turing_id = {id: 13000000}
    expected_id= @merchants_i.update(12337411, turing_id)
    expect(expected_id).to be nil
  end

  xit "deletes a merchant by id" do
      @merchants_i.delete(12337412)
      expected = @merchants_i.find_by_id(12337412)
      expect(expected).to eq nil
    end

end
