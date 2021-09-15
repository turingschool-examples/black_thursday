require './lib/sales_engine'
require 'csv'

RSpec.describe SalesEngine do
  it 'exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    expect(se).to be_an_instance_of(SalesEngine)
  end

  it 'test csv hash' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    expect(SalesEngine.item_data).to eq("./data/items.csv")
  end

  xit 'has attributes' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    expect(x).to eq("...")
  end
end
