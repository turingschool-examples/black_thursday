require 'rspec'
require './lib/merchant_repository'

describe MerchantRepository do
  describe '#initialize' do
    before(:each) do
      @mr = MerchantRepository.new
    end

    it 'is and instance of MerchantRepository' do
      expect(@mr).to be_a MerchantRepository
    end
  end
end