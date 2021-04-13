require 'RSpec'
require './lib/merchant'

RSpec.describe Merchant do
  describe 'instantiation' do
    it '::new' do
      m = Merchant.new({:id => 5, :name => "Turing School"})

    expect(m).to be_an_instance_of(Merchant)
    end
  end
end
