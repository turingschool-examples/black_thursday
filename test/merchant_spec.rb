require 'rspec'
require './lib/merchant'

describe Merchant do

  describe '#initialize' do
    it 'is an intance of Merchant class' do
      merch_hash = {id: 7, name: "Turing School"}
      m = Merchant.new(merch_hash)

      expect(m).to be_an_instance_of(Merchant)
    end
  end

end
