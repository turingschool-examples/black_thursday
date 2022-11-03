require_relative '../lib/sales_engine.rb'
require_relative '../lib/item_repository.rb'
require_relative '../lib/item.rb'
require_relative '../lib/merchant.rb'
require_relative '../lib/merchant_repository.rb'
require 'csv'

RSpec.describe SalesEngine do

  it 'exists' do
    files = {
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
    }
    se = SalesEngine.new(files)

    expect(se).to be_a(SalesEngine)
  end

  it 'can have an item repository' do
    files = {
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
    }
    se = SalesEngine.new(files)

    expect(se.items.all.all?(Item)).to be(true)
  end

  it 'can have an merchant repository' do
    files = {
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
    }
    se = SalesEngine.new(files)

    expect(se.merchants.all.all?(Merchant)).to be(true)
  end

  it 'can initialize an instance with files' do
    se = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
    })
    ir = se.items
    mr = se.merchants
    # require 'pry' ; binding.pry

    expect(ir).to respond_to(:all)
    expect(mr).to respond_to(:all)
  end
end
