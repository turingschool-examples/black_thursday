require_relative 'spec_helper'
require_relative '../lib/sales_engine'
require 'csv'


RSpec.describe SalesEngine do
  before(:each) do
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
  end
  it 'exists' do
    expect(@se).to be_an_instance_of(SalesEngine)
  end

  it 'can create an items repository' do
    expect(@se.items).to be_an_instance_of(ItemRepository)
  end

  it 'can create a merchant repository' do
    expect(@se.merchants).to be_an_instance_of(MerchantRepository)
  end

  it 'can create a sales analyst' do
    expect(@se.analyst).to be_a(SalesAnalyst)
  end
end
