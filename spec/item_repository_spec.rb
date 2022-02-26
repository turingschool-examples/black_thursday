require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
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

end
