require 'rspec'
require './lib/merchants_repository'

describe MerchantsRepository do

  describe '#initialize' do
    it 'is an instance of MerchantsRepository class' do

    merchant_array = []
    mr = MerchantsRepository.new(merchant_array)
    end
  end
end
