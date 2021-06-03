require_relative './spec_helper'

RSpec.describe MerchantRepository do
  context 'instantiation' do
    it 'exists' do
      mr = MerchantRepository.new('spec/fixtures/merchants.csv')
      expect(mr).to be_a(MerchantRepository)
    end
  end

  context 'methods' do
    before :each do
      @mr = MerchantRepository.new('spec/fixtures/merchants.csv')
      @merchant1 = @mr.all[1]
      @merchant2 = @mr.all[-1]
    end

    it 'generates merchant instances' do
      expect(@merchant1.id).to eq(12334112)
      expect(@merchant1.name).to eq('Candisart')
      expect(@merchant2.id).to eq(12334185)
      expect(@merchant2.name).to eq('Madewithgitterxx')
      expect(@mr.all).to be_a(Array)
    end


    it 'returns merchant with matching ID or nil' do
      expect(@mr.find_by_id(12334112)).to eq(@merchant1)
      expect(@mr.find_by_id(12334185)).to eq(@merchant2)
      expect(@mr.find_by_id(26866642)).to eq(nil)
    end
  end
end
