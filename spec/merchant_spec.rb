require 'rspec'
require './lib/merchant'

describe Merchant do
  m = Merchant.new({:id => 5, :name => "Turing School"})
  describe 'initialize' do
    it 'exists' do
      expect(m).to be_a(Merchant)
    end

    it 'has an id' do
      expect(m.id).to be(5)
    end

    it 'has a name' do
      expect(m.name).to eq("Turing School")
    end
  end
end
