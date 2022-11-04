require 'rspec'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

RSpec.describe do
  it 'exists' do
    m = Merchant.new({:id => 5, :name => "Turing School"})

    expect(m).to be_a(Merchant)
  end

  it 'has a name and id' do
      m = Merchant.new({:id => 5, :name => "Turing School"})

      expect(m.id).to eq(5)
      expect(m.name).to eq("Turing School")
  end

  it 'finds all the items per merchant' do
    sales_engine = SalesEngine.from_csv(

      :items     => './data/items_test2.csv',
      :merchants => './data/merchant_test2.csv'
      )
      m2 = sales_engine.merchants.all[1]

      expect(m2.items.length).to eq(4)
  end
end
