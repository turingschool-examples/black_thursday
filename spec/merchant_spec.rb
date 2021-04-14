require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/merchant_repository'

RSpec.describe Merchant do
  it 'exists' do
    merchant = Merchant.new(id: '12334105',
                            name: 'Shopin1901',
                            created_at: '2010-12-10',
                            updated_at: '2011-12-04')

    expect(merchant).to be_a(Merchant)
  end

  it 'has attributes' do
    merchant = Merchant.new(id: '12334105',
                          name: 'Shopin1901',
                          created_at: '2010-12-10',
                          updated_at: '2011-12-04')

    expect(merchant.id).to eq(12334105)
    expect(merchant.name).to eq('Shopin1901')
    expect(merchant.created_at.year).to eq(2010)
    expect(merchant.updated_at.year).to eq(2011)
  end
end