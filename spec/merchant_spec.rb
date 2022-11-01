require 'rspec'
require './lib/merchant'

describe Merchant do
  it 'exists' do
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    expect(merchant).to be_a Merchant
  end
end
