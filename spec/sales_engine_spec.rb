require_relative 'spec_helper'
require_relative '../lib/sales_engine'
require 'csv'


RSpec.describe SalesEngine do
  it 'exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se).to be_an_instance_of(SalesEngine)
  end

  xit 'can create an items repository' do
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se.items).to be_an_instance_of(ItemRepository)
  end

  xit 'can create a merchant repository' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se.merchants).to be_an_instance_of(MerchantRepository)
  end

  xit 'can create a sales analyst' do
    se = SalesEngine.from_csv{
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se.analyst).to be_a(SalesAnalyst)
  end
end
