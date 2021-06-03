require_relative 'spec_helper'
require_relative '../lib/merchant_repository'

RSpec.describe MerchantRepository do
  before :each do
    @repo = MerchantRepository.new('./spec/fixtures/mock_merchants.csv')
  end

    it 'exists' do
      expect(@repo).to be_an_instance_of(MerchantRepository)
    end

    it 'returns all merchants' do
      expect(@repo.all_merchants).to eq([nil])
    end

    it 'creates real items from csv' do
      expect(@repo.all_merchants.length).to eq(3)
      @repo.all_merchants.each do |merchant|
        expect(merchant).to be_an_instance_of(Merchant)
      end
    end

    it 'can find a merchant by id' do
      expect(@repo.find_by_id(12334105).name).to eq('Shopin1901')
      expect(@repo.find_by_id(1)).to eq(nil)
      expect(@repo.find_by_id(12334113).name).to eq('MiniatureBikez')
    end

    xit 'can find a merchant by name' do
      expect(@mock_repo.find_by_name('Shopin1901')).to eq(@merchant_1)
      expect(@mock_repo.find_by_name('Koop')).to eq(nil)
      expect(@mock_repo.find_by_name('MiniatureBikez')).to eq(@merchant_3)
    end

    xit 'can find all matches to the name fragment' do

      expect(@mock_repo.find_all_by_name('in')).to eq([@merchant_1, @merchant_4])
      expect(@mock_repo.find_all_by_name("Koop")).to eq([])
    end

    xit 'creates the next highest merchant id' do
      expect(@mock_repo.next_highest_merchant_id).to eq(12334114)
    end

    xit 'can create a new merchant instance' do
      attributes = {name: 'Koop'}

      @mock_repo.next_highest_merchant_id

      @mock_repo.create(attributes)

      expect(@merchant_repo.all_merchants).to eq([@merchant_1, @merchant_2, @merchant_3, @merchant_4, @merchant_5])
    end

    xit 'can update an exsisting merchants name' do
      attributes = {name: 'Sparky'}

      @mock_repo.update(12334114, attributes)

      expect(@mock_repo.merchant(dfle)).to be({id: 12334114, name: 'Sparky'})
    end

    xit 'can delete the merchant by id' do
      @mock_repo.delete()

      expect(@merchant_repo.all_merchants).to eq([@merchant_1, @merchant_2, @merchant_4])
    end

end
