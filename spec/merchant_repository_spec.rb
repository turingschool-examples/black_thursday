require 'csv'
require './lib/merchant'
require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  it 'exists' do
    mr = MerchantRepository.new

    expect(mr).to be_a(MerchantRepository)
  end

  it 'starts with no merchants' do
    mr = MerchantRepository.new
    expect(mr.all).to eq([])
  end

  describe 'Methods' do
    it 'finds merchant by id' do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      mr = MerchantRepository.new
      allow(mr).to receive(:all).and_return([m])
      # mr.all = [m]

      expect(mr.find_by_id(5)).to eq(m)
    end
  end
end
