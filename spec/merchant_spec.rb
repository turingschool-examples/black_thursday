require 'rspec'
require './lib/merchant'

describe Merchant do
  let!(:merchant) {Merchant.new({:id => 5, :name => "Turing School"})}
  it 'exists' do
    # merchant = Merchant.new({:id => 5, :name => "Turing School"})

    expect(merchant).to be_a Merchant
  end

  it 'can return the name' do
    # merchant = Merchant.new({:id => 5, :name => "Turing School"})

    expect(merchant.name).to eq("Turing School")
  end
end
