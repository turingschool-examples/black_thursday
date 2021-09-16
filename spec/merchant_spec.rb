require './lib/merchant'

RSpec.describe do
  it 'exists' do
    merchant = Merchant.new({:id => 12345678, :name => 'KCAMP' })

  expect(merchant).to be_an_instance_of(Merchant)
  end
end
