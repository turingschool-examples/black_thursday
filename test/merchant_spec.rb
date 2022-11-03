require './lib/merchant'

RSpec.describe Merchant do
  it 'exists and has attributes' do
    merchant = Merchant.new({ id: 5, name: 'Turing School' })

    expect(merchant).to be_a(Merchant)
    expect(merchant.id).to eq(5)
    expect(merchant.name).to eq('Turing School')
  end
end
