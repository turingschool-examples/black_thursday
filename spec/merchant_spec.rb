# frozen_string_literal: true

require_relative '../lib/merchant'

RSpec.describe Merchant do
  let(:merchant) { Merchant.new({ id: 5, name: 'Turing School' }) }
  it 'exists' do
    expect(merchant).to be_a Merchant
  end

  it 'can return the name' do
    expect(merchant.name).to eq('Turing School')
  end

  it 'can return the id' do
    expect(merchant.id).to eq(5)
  end
end
