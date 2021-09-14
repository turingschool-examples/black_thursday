require 'rspec'
require './lib/merchant'

describe Merchant do

  describe '#initialize' do
    it 'is an intance of Merchant class' do
      m = Merchant.new

      expect(m).to be_an_instance_of(Merchant)
    end
  end

end
