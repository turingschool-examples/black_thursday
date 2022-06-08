require 'simplecov'
SimpleCov.start
require './lib/helper'

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
      :id => "5",
      :name => "Turing School"
      })

    expect(merchant.id).to eq(5)
  end

  it 'returns name' do
    merchant = Merchant.new({
      :id => 5,
      :name => "Turing School"
      })

    expect(merchant.name).to eq("Turing School")
  end

end
