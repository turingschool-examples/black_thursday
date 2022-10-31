require './lib/merchant'

RSpec.describe Merchant do
  let(:merchant) {Merchant.new({:id => 1, :name => "Turing School"})}

  it 'is an instance of a merchant' do
    expect(merchant).to be_a(Merchant)
  end

  it 'has an id and name attribute which are accessible' do
    expect(merchant.id).to eq(1)
    expect(merchant.name).to eq("Turing School")
  end


end