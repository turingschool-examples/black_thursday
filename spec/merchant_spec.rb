require_relative 'spec_helper'
require_relative '../lib/merchant'
require 'csv'

RSpec.describe do
  it 'exists' do
    data = {id: 5, name: 'Turing'}
    merchant = Merchant.new(data)

    expect(merchant).to be_a Merchant
  end

  it 'has attributes' do
    data = {id: 5, name: 'Turing'}
    merchant = Merchant.new(data)

    expect(merchant.id).to eq(5)
    expect(merchant.name).to eq('Turing')
  end
end
