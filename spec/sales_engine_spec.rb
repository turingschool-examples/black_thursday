require 'csv'
require './lib/sales_engine'
require './lib/merchant'

RSpec.describe SalesEngine do
  it 'exists' do
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    expect(sales_engine).to be_a(SalesEngine)
  end
end