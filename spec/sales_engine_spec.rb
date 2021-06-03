require_relative 'spec_helper'

RSpec.describe SalesEngine do
  it 'can read from csv class method' do
    paths = {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    }
    se = SalesEngine.from_csv(paths)

    expect(se.merchants.class).to eq(MerchantRepository)
    expect(se.merchants.all.class).to eq(Array)
    expect(se.merchants.all.length).to eq(475)

    expect(se.items.class).to eq(ItemRepository)
    expect(se.items.all.class).to eq(Array)
    expect(se.items.all.length).to eq(1367)
  end

end
