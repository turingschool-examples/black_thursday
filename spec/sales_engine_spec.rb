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

  it 'can create an items repository' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se.items).to be_an_instance_of(ItemRepository)
  end

  it 'can create a merchant repository' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se.merchants).to be_an_instance_of(MerchantRepository)
  end
end
