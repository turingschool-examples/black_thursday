require 'rspec'
require './lib/merchant'

describe Merchant do
  describe '#initialize' do
    it 'exists' do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      expect(m).to be_an_instance_of(Merchant)
    end

    it 'has a name' do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      expect(m.name).to eq("Turing School")
    end

    it 'has an id' do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      expect(m.id).to eq(5)
    end
  end
end
