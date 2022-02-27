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


end
