require 'rspec'
require_relative '../lib/sales_engine'

describe SalesEngine do
  before :each do
    @se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    })
  end

  it 'is a SalesEngine' do
    expect(@se).to be_a SalesEngine
  end

  it 'can call merchantrepo methods' do
    mr = @se.merchants
    merchant = mr.find_by_name("CJsDecor")

    expect(merchant).to be_a Merchant
  end

  it 'can call ItemRepository methods' do
    ir   = @se.items
    item = ir.find_by_name("510+ RealPush Icon Set")

    expect(item).to be_a Item
  end
end