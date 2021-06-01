require 'csv'
require './lib/merchant_repository'
require 'simplecov'
SimpleCov.start

RSpec.describe MerchantRepository do

  before :each do
    @mr = MerchantRepository.new
    @m = Merchant.new({:id => 5, :name => "Turing School"})
    @m2 = Merchant.new({:id => 4, :name => "Turing Bakery"})
  end

  describe 'instantiation' do

    it 'exists' do
      expect(@mr).to be_a(MerchantRepository)
    end

    it 'starts with no merchants' do
      expect(@mr.all).to eq([])
    end
  end

  describe 'Methods' do

    it 'finds merchant by attributes' do
      allow(@mr).to receive(:all).and_return([@m])

      expect(@mr.find_by_id(5)).to eq(@m)
      expect(@mr.find_by_id(27)).to eq(nil)
      expect(@mr.find_by_name('Turing School')).to eq(@m)
      expect(@mr.find_by_name('TuriNg schOOl')).to eq(@m)
      expect(@mr.find_by_name('Banana Factory')).to eq(nil)
    end

    it 'finds all merchants by partial match' do
      allow(@mr).to receive(:all).and_return([@m, @m2])

      expect(@mr.find_all_by_name('turIng')).to eq([@m, @m2])
      expect(@mr.find_all_by_name('super 6')).to eq([])
    end

    it 'creates new Merchant with attributes' do
      allow(@mr).to receive(:all).and_return([@m, @m2])
      m3 = @mr.create("Bob's Burgers").last

      expect(m3.id).to eq(6)
      expect(m3.name).to eq("Bob's Burgers")
      expect(m3).to be_a(Merchant)
    end

    it 'updates Merchant attributes' do
      allow(@mr).to receive(:all).and_return([@m, @m2])
      @mr.update(5, {:name => 'turingschool.edu'})

      expect(@m.id).to eq(5)
      expect(@m.name).to eq("turingschool.edu")
    end

    it 'deletes Merchant by id' do
      allow(@mr).to receive(:all).and_return([@m, @m2])
      @mr.delete(4)

      expect(@mr.all).to eq([@m])
    end
  end
end
