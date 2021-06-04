require 'spec_helper'


RSpec.describe Merchant do
  describe '#initialize' do
    it 'exists' do
      merchant = Merchant.new({:id => 5, :name => "Turing School"})

      expect(merchant).to be_a(Merchant)
    end

    it 'has attributes' do
      merchant = Merchant.new({:id => 5, :name => "Turing School"})

      expect(merchant.id).to eq(5)
      expect(merchant.name).to eq("Turing School")
    end
  end
end
