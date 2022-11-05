require './lib/merchant'

RSpec.describe Merchant do
  let(:merchant) { Merchant.new({ id: 5, name: 'Turing School' })}

  it '#initialize' do
    expect(merchant).to be_a(Merchant)
    expect(merchant.id).to eq(5)
    expect(merchant.name).to eq('Turing School')
  end

  it '#update' do
    merchant.update({ id: 4, name: 'School' })
    expect(merchant.name).to eq('School')
    expect(merchant.id).to eq(5)
  end
end
