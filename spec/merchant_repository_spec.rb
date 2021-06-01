require_relative 'spec_helper'
require './lib/merchant_repository'


RSpec.describe MerchantRepository do
  before :each do
    @merchant_1 = double('merchant_1')
    @merchant_2 = double('merchant_2')
    @merchant_3 = double('merchant_3')
    @merchant_4 = double('merchant_4')
    allow_any_instance_of(MerchantRepository).to recieve(:create_merchants).and_return(@items)
    @merchant_repo = MerchantRepository.new('path')
  end

    it 'exsits' do
      expect(@merchant_repo).to be_an_instance_of(MerchantRepository)
    end

    it 'can find a merchant by id' do
      allow(@merchant_1).to recieve(:id).and_return(12)
      allow(@merchant_2).to recieve(:id).and_return(18)
      allow(@merchant_3).to recieve(:id).and_return(72)
      allow(@merchant_4).to recieve(:id).and_return(2)

      expect(@merchant_repo.find_by_id(12)).to eq(@merchant_1)
      expect(@merchant_repo.find_by_id(27)).to eq(nil)
      expect(@merchant_repo.find_by_id(72)).to eq(@merchant_3)
      expect(@merchant_repo.find_by_id(2021)).to eq(nil)
    end

    it 'can find a merchant by name' do
      allow(@merchant_1).to recieve(:name).and_return(12)
      allow(@merchant_2).to recieve(:name).and_return(18)
      allow(@merchant_3).to recieve(:name).and_return(72)
      allow(@merchant_4).to recieve(:name).and_return(2)

      expect(@merchant_repo.find_by_id(12)).to eq(@merchant_1)
      expect(@merchant_repo.find_by_id(27)).to eq(nil)
      expect(@merchant_repo.find_by_id(72)).to eq(@merchant_3)
      expect(@merchant_repo.find_by_id(2021)).to eq(nil)



    end

    it 'can find all matches to the name fragment' do
      se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      })
      mr = se.merchants

      expect(mr.find_all_by_name("Helen")).to eq([])
      expect(mr.find_all_by_name("CJsDecor")).to eq()
    end

  end
end
