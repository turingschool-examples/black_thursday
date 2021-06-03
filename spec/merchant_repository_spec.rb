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

    it 'returns merchant with matching name or nil' do
      expect(@mr.find_by_name('Candisart')).to eq(@merchant1)
      expect(@mr.find_by_name('Madewithgitterxx')).to eq(@merchant2)
      expect(@mr.find_by_name('footballs')).to eq(nil)
    end

    it 'returns merchant with supplied name fragment' do
      expect(@mr.find_all_by_name('Candi')).to eq([@merchant1])
      expect(@mr.find_all_by_name('Madew')).to eq([@merchant2])
      expect(@mr.find_all_by_name('footba')).to eq([])
    end

    it 'creates a new merchant' do
      expect(@mr.new_id).to eq(12334186)
    end

    it 'creates a new merchant instance with given attributes' do
      attributes = {
        :id          => nil,
        :name        => "Bob's Airplanes"
      }
      expect(@mr.create(attributes)).to be_a(Merchant)
    end

    it 'updates merchant by id with given attributes' do

      attributes = {
        :id          => 12334102,
        :name        => 'Candismath'
      }
      @mr.update(12334112, attributes)

      expect(@merchant1.id).to eq(12334102)
      expect(@merchant1.name).to eq('Candismath')
    end

    it 'delete merchant by id' do
      expect(@mr.all.length).to eq(20)
      expect(@mr.delete(12334112)).to eq(@merchant1)
      expect(@mr.all.length).to eq(19)
    end
  end
end
