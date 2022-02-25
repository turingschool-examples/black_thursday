require_relative '../lib/item_repository'
require_relative 'spec_helper'
require 'pry'

RSpec.describe MerchantRepository do

  before(:each) do
    @se = SalesEngine.from_csv({:items=> "./data/items.csv", :merchants => "./data/merchants.csv",})
    @merchants = MerchantRepository.new(@se[1])

  end



  it "exist" do
    expect(@merchants).to be_a(MerchantRepository)
  end

  it "holds #all merchant data" do
    expect(@merchants.all.count).to eq(476)
  end

end
