require 'SimpleCov'
SimpleCov.start

require_relative '../lib/sales_engine'

RSpec.describe SalesEngine do
  it 'exists' do
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    expect(se).to be_an_instance_of(SalesEngine)
  end

  it 'initializes with attributes' do
    data = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    }

    se = SalesEngine.new(data)

    expect(se.items).to eq(data[:items])
    expect(se.merchants).to eq(data[:merchants])
  end
end
