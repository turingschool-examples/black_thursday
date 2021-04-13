require 'RSpec'
require './lib/merchant'

RSpec.describe Merchant do
  describe 'instantiation' do
    it '::new' do
      m = Merchant.new({:id => 5, :name => "Turing School"})

    expect(m).to be_an_instance_of(Merchant)
    end

    it 'has attributes' do
      m = Merchant.new({:id => 5, :name => "Turing School"})

      expect(m.id).to eq(5)
      expect(m.name).to eq("Turing School")
    end
  end
end
