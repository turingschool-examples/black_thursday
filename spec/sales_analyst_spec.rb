require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative 'spec_helper'
require 'pry'

RSpec.describe SalesAnalyst do

  before(:each) do
    se = SalesEngine.from_csv({:items=> "./data/items.csv", :merchants => "./data/merchants.csv",})
    @analyst = se.analyst
    # binding.pry
  end


  it 'calculates average items per merchant' do
    average_item = @analyst.average_items_per_merchant
    expect(average_item).to eq 2.88
    expect(average_item.class).to be Float
  end

  it 'calculates average items per standard deviation' do
    average_item = @analyst.average_items_per_merchant_standard_deviation
    expect(average_item).to eq 3.26
    expect(average_item.class).to be Float
  end

  it 'returns merchants with high item counts' do
    merchants_with_high_count = @analyst.merchants_with_high_item_count
    expect(merchants_with_high_count.length).to eq 52
    expect(merchants_with_high_count.first.class).to eq Merchant
  end

   it 'returns average price of given merchant' do
     average_price_per_merchant = @analyst.average_item_price_for_merchant(12334105)
     expect(average_price_per_merchant).to eq 16.66
   end

   it 'returns average price for all merchants' do
     average_price_all_merchants = @analyst.average_average_price_per_merchant
     expect(average_price_all_merchants).to eq 350.29
   end

   it 'returns golden items' do
     golden_items = @analyst.golden_items
     expect(golden_items.length).to eq 5
     expect(golden_items.first.class).to eq Item
   end
end
