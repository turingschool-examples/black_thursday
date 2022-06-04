require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe Merchant do
  let!(:time) {Time.now}
  let!(:merchant) {Merchant.new({
    :id => 5,
    :name => "Turing School"
  })}

  it 'exists' do
    expect(merchant).to be_instance_of(Merchant)
  end

  it 'returns id' do
    expect(merchant.id).to eq(5)
  end

  it 'returns name' do
    expect(merchant.name).to eq("Turing School")
  end

end
