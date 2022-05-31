require 'simplecov'
SimpleCov.start
require './lib/merchant'
require 'rspec'

RSpec.describe Merchant do

  it 'exists' do
    merchant = Merchant.new({
      :id => 5,
      :name => "Turing School"
      })

    expect(merchant).to be_instance_of(Merchant)
  end

  it 'returns id' do
    merchant = Merchant.new({
      :id => 5,
      :name => "Turing School"
      })

    expect(merchant.id).to eq(5)
  end

end
