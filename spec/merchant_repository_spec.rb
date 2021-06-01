require 'csv'
require './lib/merchant'
require './lib/merchant_repository'
require 'simplecov'
SimpleCov.start

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
    it 'finds merchant by attributes' do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      mr = MerchantRepository.new
      allow(mr).to receive(:all).and_return([m])
      # mr.all = [m]

      expect(mr.find_by_id(5)).to eq(m)
      expect(mr.find_by_name('Turing School')).to eq(m)
      expect(mr.find_by_name('TuriNg schOOl')).to eq(m)
    end

    it 'finds all merchants by partial match' do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      m2 = Merchant.new({:id => 4, :name => "Turing Bakery"})
      mr = MerchantRepository.new
      allow(mr).to receive(:all).and_return([m, m2])

      expect(mr.find_all_by_name('turIng')).to eq([m, m2])
    end

    it 'creates new Merchant with attributes' do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      m2 = Merchant.new({:id => 4, :name => "Turing Bakery"})
      mr = MerchantRepository.new
      allow(mr).to receive(:all).and_return([m, m2])
      m3 = mr.create("Bob's Burgers")

      expect(m3.id).to eq(6)
      expect(m3.name).to eq("Bob's Burgers")
      expect(m3).to be_a(Merchant)
    end

    it 'updates Merchant attributes' do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      m2 = Merchant.new({:id => 4, :name => "Turing Bakery"})
      mr = MerchantRepository.new
      allow(mr).to receive(:all).and_return([m, m2])
      mr.update(5, "turingschool.edu")

      expect(m.id).to eq(5)
      expect(m.name).to eq("turingschool.edu")
    end

    it 'deletes Merchant by id' do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      m2 = Merchant.new({:id => 4, :name => "Turing Bakery"})
      mr = MerchantRepository.new
      allow(mr).to receive(:all).and_return([m, m2])
      mr.delete(4)

      expect(mr.all).to eq([m])
    end
  end
end
