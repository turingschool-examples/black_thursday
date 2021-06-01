require 'SimpleCov'
SimpleCov.start

require_relative '../lib/salesengine'
require_relative '../lib/merchant'
require_relative '../lib/merchantrepository'

RSpec.describe MerchantRepository do
  it 'exists' do
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Something Else"})
    mr = MerchantRepository.new([m, m2])

    expect(mr).to be_an_instance_of(MerchantRepository)
  end

  it 'initializes with attributes' do
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Something Else"})
    mr = MerchantRepository.new([m, m2])

    expect(mr.merchants).to eq([m, m2])
  end

  it 'returns a list of known merchants' do
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Something Else"})
    mr = MerchantRepository.new([m, m2])

    expect(mr.all).to eq([m, m2])
  end

  it 'returns a merchant with a matching id' do
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Something Else"})
    mr = MerchantRepository.new([m, m2])

    expect(mr.find_by_id(5)).to eq(m)
    expect(mr.find_by_id(6)).to eq(m2)
  end

  it 'returns a merchant by name' do
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Something Else"})
    mr = MerchantRepository.new([m, m2])

    expect(mr.find_by_name("TuRing ScHool")).to eq(m)
    expect(mr.find_by_name("Something Else")).to eq(m2)
  end

  it 'returns all merchants by name' do
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "TURING SCHOOL"})
    mr = MerchantRepository.new([m, m2])

    expect(mr.find_all_by_name("Turing School")).to eq([m, m2])
    expect(mr.find_all_by_name("Something Else")).to eq([])
  end

  it 'creates a new merchant with attributes' do
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Something Else"})
    mr = MerchantRepository.new([m, m2])
    m3 = mr.create("Another Merchant")

    expect(mr.merchants).to eq([m, m2, m3])
  end

  it 'finds merchant by id and updates name' do
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Something Else"})
    mr = MerchantRepository.new([m, m2])

    mr.update(5, "Turing School of Coding")

    expect(m.name).to eq("Turing School of Coding")
    expect(m.id).to eq(5)
  end

  it "finds and deletes merchant by id" do
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Something Else"})
    mr = MerchantRepository.new([m, m2])

    mr.delete(6)

    expect(mr.merchants).to eq([m])
  end
end
