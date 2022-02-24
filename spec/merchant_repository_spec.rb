# Merchant Repository Spec
require './lib/merchant_repository'
require 'pry'

RSpec.describe 'Iteration 0' do
  context 'Merchant Repository' do
    it '#all returns an array of all merchant instances' do
      expected = merchant_repository.all
      expect(expected.count).to eq(475)
    end
  end
end
