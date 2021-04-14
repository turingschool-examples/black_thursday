require 'CSV'
require 'RSpec'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repository'
# require './data/merchants.csv'

RSpec.describe MerchantRepo do
  describe 'instantiation' do
    it '::new' do
      merchant_repo = MerchantRepo.new

    expect(merchant_repo).to be_an_instance_of(MerchantRepo)
    end
  end

  describe '#methods' do
    it '#populates information' do
      merchant_repo = MerchantRepo.new

      expect(merchant_repo.populate_information).to be_an_instance_of(Hash)
    end

    it '#all' do
      merchant_repo = MerchantRepo.new
      merchant_repo.populate_information

      expect(merchant_repo.all.length).to eq(475)
      # Is it acceptable to be testing this?
      expect(merchant_repo.all).to be_an_instance_of(Array)

    end

    it '#find merchant by ID' do
      merchant_repo = MerchantRepo.new
      merchant_repo.populate_information
      merchant_repo.all

      #consider alternative assertion
      expect(merchant_repo.find_by_id("12334105").name).to eq("Shopin1901")
      expect(merchant_repo.find_by_id("999999999")).to eq(nil)
    end

    it '#find merchant by name' do
      merchant_repo = MerchantRepo.new
      merchant1 = Merchant.new({:id => 5, :name => "Turing School"})
      # merchant_repo.populate_information
      # merchant_repo.all

      merchant_repo.add_merchant(merchant1)
      # require "pry"; binding.pry
      expect(merchant_repo.find_by_name("Turing School")).to eq(merchant1)

      # expect(merchant_repo.find_by_name("Shopin1901").id).to eq("12334105")
      expect(merchant_repo.find_by_name("Hogwarts School")).to eq(nil)
    end

    it '#find all merchants by name' do
      merchant_repo = MerchantRepo.new
      merchant_repo.populate_information
      merchant_repo.all
      # require "pry"; binding.pry
      expect(merchant_repo.find_all_by_name("Hogwar")).to eq([])
      expect(merchant_repo.find_all_by_name("gem").length).to eq(5)
    end

    xit '#create merchant' do
      merchant_repo = MerchantRepo.new
      merchant_repo.populate_information
      merchant_repo.all

      expect(merchant_repo.create()).to eq(5)
    end

    xit '#delete merchant' do
      merchant_repo = MerchantRepo.new
      merchant_repo.populate_information
      merchant_repo.all

      expect(merchant_repo.create()).to eq(5)
    end
  end
end
