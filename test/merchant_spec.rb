require './test/spec_helper'


RSpec.describe Merchant do
  describe 'iteration 0' do
    before :each do
      @m = Merchant.new({:id => 5, :name => "Turing School"})
    end

    it 'exists' do

      expect(@m).to be_a(Merchant)
    end

    it 'has readable attributes' do

      expect(@m.id).to eq(5)
      expect(@m.name).to eq("Turing School")
    end
  end
end
