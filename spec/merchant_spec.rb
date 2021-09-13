require'./lib/merchant.rb'

RSpec.describe Merchant do
  it 'exists' do
    data = {id: 5, name: "Turing School"}
    merchant = Merchant.new(data)

    expect(merchant).to be_a Merchant
  end

  it 'has attributes' do
    data = {id: 5, name: "Turing School"}
    merchant = Merchant.new(data)

    expect(merchant.name).to eq "Turing School"
    expect(merchant.id).to eq 5
  end
end
