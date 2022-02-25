require 'pry'
require './lib/sales_engine'
require 'rspec'
require 'simplecov'

SimpleCov.start

RSpec.describe SalesEngine do
  it 'exists' do
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    expect(se.class).to eq(SalesEngine)
  end

  



end
