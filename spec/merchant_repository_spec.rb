require 'CSV'
require_relative '../lib/merchant_repository'
require 'simplecov'
SimpleCov.start

RSpec.describe MerchantRepository do

  before :each do
    @mr = MerchantRepository.new('./spec/fixtures/merchants.csv')
    @m = Merchant.new({:id => 5, :name => "Turing School"})
    @m2 = Merchant.new({:id => 4, :name => "Turing Bakery"})
  end

  describe 'instantiation' do

    it 'exists' do
      expect(@mr).to be_a(MerchantRepository)
    end

    it 'has readable attributes' do
      expect(@mr.all).to be_a(Array)
    end
  end

  describe 'Methods' do

    it 'finds merchant by attributes' do
      @mr.all << @m
      expect(@mr.find_by_id(5)).to eq(@m)
      expect(@mr.find_by_id(27)).to eq(nil)
      expect(@mr.find_by_name('Turing School')).to eq(@m)
      expect(@mr.find_by_name('TuriNg schOOl')).to eq(@m)
      expect(@mr.find_by_name('Banana Factory')).to eq(nil)
    end

    it 'finds all merchants by partial match' do
      @mr.all << @m << @m2
      expect(@mr.find_all_by_name('turIng')).to eq([@m, @m2])
      expect(@mr.find_all_by_name('super 6')).to eq([])
    end

    it 'creates new Merchant with attributes' do
      attributes = {
        name: "Bob's Burgers"
      }
      @mr.create(attributes)

      expect(@mr.all[7].name).to eq("Bob's Burgers")
    end

    it 'updates Merchant attributes' do
      @mr.all << @m << @m2
      @mr.update(5, {:name => 'turingschool.edu'})

      expect(@m.id).to eq(5)
      expect(@m.name).to eq("turingschool.edu")
    end

    it "#update on unknown merchant does nothing" do
      @mr.update(13000000, {})
    end

    it 'deletes Merchant by id' do
      expect(@mr.find_by_id(12334105)).to be_a Merchant

      @mr.delete(12334105)

      expect(@mr.all.length).to eq(6)
      expect(@mr.find_by_id(12334105)).to eq(nil)
    end

    it 'populates repository' do
      path = "./spec/fixtures/merchants.csv"
      @mr.populate_repository(path)

      expect(@mr.all.count).to eq(14)
    end

  end
end
