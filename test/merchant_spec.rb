require './spec_helper'


RSpec.describe Merchant do
  describe '#initialize' do
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

  describe '#update_name' do
    it 'updates a merchant objects name' do
      @m = Merchant.new({:id => 5, :name => "Turing School"})
      @m.update_name("Westpoint")

      expect(@m.name).to eq("Westpoint")
    end
  end
end
