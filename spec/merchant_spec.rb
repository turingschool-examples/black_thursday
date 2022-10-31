require 'rspec'
require './lib/merchant'

describe Merchant do
  describe '#initialize' do
    before(:each) do
      merchant = Merchant.new({:id => 5, :name => "Turing School"})
    end

    it 'is an instance of Merchant' do
      expect(merchant).to be_a Merchant
    end
  end
end