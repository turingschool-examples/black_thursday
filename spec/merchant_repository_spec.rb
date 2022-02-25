require_relative '../lib/merchant_repository'
require 'simplecov'
SimpleCov.start

RSpec.describe MerchantRepository do

  before(:each) do
    @merchant_repo = MerchantRepository.new('./data/mini_merchants.csv')
  end

  describe '#initialize' do
    it 'is initialized with a data file' do

      expect(@merchant_repo.filename).to eq('./data/mini_merchants.csv')
    end
  end

  describe '#rows' do
    it 'can create a CSV::Table object' do

      expect(@merchant_repo.rows).to be_a(CSV::Table)
    end
  end

  describe '#current_highest_id' do
    it 'can sort the rows of csv data by id number from lowest to highest' do

      expect(@merchant_repo.current_highest_id).to eq(12334183)
    end
  end

  describe '#all' do
    it 'can create a merchant instance for every line on the data file' do

      expect(@merchant_repo.all.count).to eq(19)
    end
  end

  describe '#find_by_id' do
    it 'can create merchant instances for each id passed as an argument' do

      expect(@merchant_repo.find_by_id(12334105)).to be_a(Merchant)
      expect(@merchant_repo.find_by_id(12334105).id).to eq(12334105)
      expect(@merchant_repo.find_by_id(00000000)).to eq(nil)
    end
  end

  describe '#find_by_name' do
    it 'can create merchant instances for each name passed as an argument' do

      expect(@merchant_repo.find_by_name("Shopin1901")).to be_a(Merchant)
      expect(@merchant_repo.find_by_name("Shopin1901").name).to eq("Shopin1901")

      expect(@merchant_repo.find_by_name("King Sooper's")).to eq(nil)
    end
  end

  describe '#find_all_by_name' do
    it 'can create merchant instances for all lines containing the name fragment passed as an argument' do

      expect(@merchant_repo.find_all_by_name("in").count).to eq(4)
      expect(@merchant_repo.find_all_by_name("o").count).to eq(12)
    end
  end

  describe '#create' do
    it 'can create new merchants with attributes' do
      expect(@merchant_repo.create({name: "King Sooper's"}).id).to eq(12334184)
      expect(@merchant_repo.merchants.count).to eq(20)
    end
  end

  describe '#update' do
    it 'can update the name for a given id' do
      @merchant_repo.create({name: "King Sooper's"})
      @merchant_repo.update(12334184, {name: "Safeway"})
      expect(@merchant_repo.find_by_id(12334184).name).to eq("Safeway")
    end
  end

  describe '#delete' do
    it 'can delete merchants by id' do
      @merchant_repo.create({name: "King Sooper's"})
      @merchant_repo.delete(12334184)
      expect(@merchant_repo.find_by_id(12334184)).to eq(nil)
    end
  end

end
