require_relative './lib/merchant'

RSpec.describe do
  it 'exists' do
    merchant = Merchant.new({:id => 12345678, :name => 'KCAMP' })

  expect(merchant).to be_an_instance_of(Merchant)
  end

  it 'has attributes as a hash' do
    merchant = Merchant.new({:id => 12345678, :name => 'KCAMP' })

    expect(merchant.id).to eq(12345678)
    expect(merchant.name).to eq('KCAMP')

  end
end
