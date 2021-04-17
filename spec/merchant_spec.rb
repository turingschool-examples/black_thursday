require 'RSpec'
require './lib/merchant'

RSpec.describe Merchant do
  describe 'instantiation' do
    
    it '::new' do
      merchant1 = Merchant.new({:id => 5, :name => "Turing School"}, @repo)

    expect(merchant1).to be_an_instance_of(Merchant)
    end

    it 'has attributes' do
      merchant1 = Merchant.new({:id => 5, :name => "Turing School"}, @repo)

      expect(merchant1.id).to eq(5)
      expect(merchant1.name).to eq("Turing School")
    end
  end
end
