require_relative '../lib/merchant_repository'
require_relative 'spec_helper'
require 'pry'

RSpec.describe MerchantRepository do

  before(:each) do
    data = SalesEngine.from_csv({:items=> "./data/items.csv", :merchants => "./data/merchants.csv",})
    se = SalesEngine.new(data)
    @merchants =se.merchants
  end



  it "exist" do
    expect(@merchants).to be_a(MerchantRepository)
  end

  it "holds #all merchant data" do
    expect(@merchants.all.count).to eq(476)
  end

  it "can find by id" do
    merchant_found = @merchants.find_by_id('12334155')
    expect(merchant_found.id).to eq('12334155')
    expect(merchant_found.name).to eq('DesignerEstore')
  end


end
