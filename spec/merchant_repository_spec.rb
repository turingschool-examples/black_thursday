require_relative 'spec_helper'
require './lib/merchant_repository'


RSpec.describe MerchantRepository do
  before :each do
    @merchant_1 = double('merchant_1')
    @merchant_2 = double('merchant_2')
    @merchant_3 = double('merchant_3')
    @merchant_4 = double('merchant_4')
    @merchants = [@merchant_1, @merchant_2, @merchant_3, @merchant_4]
    allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(@merchants)
    @merchant_repo = MerchantRepository.new('path')
  end

    it 'exsits' do
      expect(@merchant_repo).to be_an_instance_of(MerchantRepository)
    end

    it 'returns all merchants' do
      expect(@merchant_repo.all_merchants).to eq([@merchant_1, @merchant_2, @merchant_3, @merchant_4])
    end

    it 'can find a merchant by id' do
      allow(@merchant_1).to receive(:id).and_return(100)
      allow(@merchant_2).to receive(:id).and_return(101)
      allow(@merchant_3).to receive(:id).and_return(102)
      allow(@merchant_4).to receive(:id).and_return(103)

      expect(@merchant_repo.find_by_id(100)).to eq(@merchant_1)
      expect(@merchant_repo.find_by_id(27)).to eq(nil)
      expect(@merchant_repo.find_by_id(102)).to eq(@merchant_3)
      expect(@merchant_repo.find_by_id(2021)).to eq(nil)
    end

    it 'can find a merchant by name' do
      allow(@merchant_1).to receive(:name).and_return("Lee")
      allow(@merchant_2).to receive(:name).and_return("Marla")
      allow(@merchant_3).to receive(:name).and_return("Miriam")
      allow(@merchant_4).to receive(:name).and_return("Lee")

      expect(@merchant_repo.find_by_name("Lee")).to eq(@merchant_1)
      expect(@merchant_repo.find_by_name("Carina")).to eq(nil)
      expect(@merchant_repo.find_by_name("Miriam")).to eq(@merchant_3)
    end

    it 'can find all matches to the name fragment' do
      allow(@merchant_1).to receive(:name).and_return("Lee H")
      allow(@merchant_2).to receive(:name).and_return("Marla")
      allow(@merchant_3).to receive(:name).and_return("Miriam")
      allow(@merchant_4).to receive(:name).and_return("Lee W")

      expect(@merchant_repo.find_all_by_name("Lee")).to eq([@merchant_1, @merchant_4])
      expect(@merchant_repo.find_all_by_name("Carina")).to eq([])
    end

    it 'creates the next highest merchant id' do
      allow(@merchant_1).to receive(:id).and_return(100)
      allow(@merchant_2).to receive(:id).and_return(101)
      allow(@merchant_3).to receive(:id).and_return(102)
      allow(@merchant_4).to receive(:id).and_return(103)

      expect(@merchant_repo.next_highest_merchant_id).to eq(104)
    end

    # it 'can create a new merchant instance' do
    #   allow(@merchant_1).to receive(:id).and_return(100)
    #   allow(@merchant_2).to receive(:id).and_return(101)
    #   allow(@merchant_3).to receive(:id).and_return(102)
    #   allow(@merchant_4).to receive(:id).and_return(103)
    #
    #   @merchant_repo.next_highest_merchant_id
    #   @merchant_repo.create("Koop")
    #
    #   expect(@merchant_repo.all_merchants).to eq([@merchant_1, @merchant_2, @merchant_3, @merchant_4, @merchant_5])
    # end

    # it 'can update an exsisting merchants name' do
    #   allow(@merchant_1).to receive(:name).and_return("Lee")
    #   allow(@merchant_2).to receive(:name).and_return("Marla")
    #   allow(@merchant_3).to receive(:name).and_return("Miriam")
    #   allow(@merchant_4).to receive(:name).and_return("Lee")
    #
    #
    # end

    it 'can delete the merchant by id' do
      allow(@merchant_1).to receive(:id).and_return(100)
      allow(@merchant_2).to receive(:id).and_return(101)
      allow(@merchant_3).to receive(:id).and_return(102)
      allow(@merchant_4).to receive(:id).and_return(103)

      @merchant_repo.delete(102)

      expect(@merchant_repo.all_merchants).to eq([@merchant_1, @merchant_2, @merchant_4])
    end

end
