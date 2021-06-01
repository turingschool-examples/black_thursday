require 'CSV'
require './lib/merchant'
require 'simplecov'
SimpleCov.start

RSpec.describe Merchant do

  describe 'instantiation' do
    it 'exists' do
      m = Merchant.new({:id => 5, :name => "Turing School"})

      expect(m).to be_a(Merchant)
    end

    it 'has attributes' do
      m = Merchant.new({:id => 5, :name => "Turing School"})

      expect(m.id).to eq(5)
      expect(m.name).to eq('Turing School')
    end
  end

  describe 'Methods' do
    it 'can update the Merchant with provided attributes' do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      attributes = {:name => 'turingschool.edu'}
      m.update(attributes)

      expect(m.name).to eq('turingschool.edu')
    end
  end
end
