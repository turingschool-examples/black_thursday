require './lib/sales_engine'
require 'csv'

RSpec.describe SalesEngine do
  it 'exists' do
     se = SalesEngine.from_csv({
       :items     => "./data/items.csv",
       :merchants => "./data/merchants.csv",
       })
    expect(se).not_to eq nil
  end

  xit 'creates an array of item hashes' do
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

  it 'returns the merchants' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    expect(se[:merchants]).not_to be nil
  end

end
