require 'rspec'
require './lib/merchant'
require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  it 'can return an array of Merchant instances' do
    mr = MerchantRepository.new

    expect(mr.all).to eq([])
  end

  describe '#add_merchant' do
    it 'adds merchant instances to all array' do
      mr = MerchantRepository.new
      m = Merchant.new({:id => 5, :name => "Turing School"})
      mr.add_merchant(m)

      expect(mr.all).to eq([m])
    end
  end

  describe '#find_by_id' do

    it 'returns either nil or an instance of Merchant with a matching ID' do
      mr = MerchantRepository.new
      m = Merchant.new({:id => 5, :name => "Turing School"})
      m2 = Merchant.new({:id => 2, :name => "Other School"})
      mr.add_merchant(m)
      mr.add_merchant(m2)

      expect(mr.find_by_id(5)).to eq(m)
      expect(mr.find_by_id(1)).to eq(nil)
      expect(mr.find_by_id(2)).to eq(m2)
      expect(mr.find_by_id(7)).to eq(nil)

    end
  end

  it 'returns either nil or an instance of Merchant having done a case insensitive search' do
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 2, :name => "Other School"})
    mr.add_merchant(m)
    mr.add_merchant(m2)

    expect(mr.find_by_name("Turing School")).to eq(m)
  end
end
