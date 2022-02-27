require 'pry'
require 'rspec'
require 'simplecov'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative '../lib/findable'
require_relative '../lib/sales_engine'

SimpleCov.start

RSpec.describe MerchantRepository do
  it 'exists' do
    mr = MerchantRepository.new([])
    expect(mr.class).to eq(MerchantRepository)
  end

  it 'can return an array of all merchant objects' do
    m_1 = Merchant.new({ :id => 1, :name => "True Value" })
    m_2 = Merchant.new({ :id => 2, :name => "Home Depot" })
    m_3 = Merchant.new({ :id => 3, :name => "Walmart" })
    m_4 = Merchant.new({ :id => 4, :name => "K Mart" })
    mr = MerchantRepository.new([m_1, m_2, m_3, m_4])
    expect(mr.all).to eq([m_1, m_2, m_3, m_4])
  end

  it 'can find a merchant by id' do
    m_1 = Merchant.new({ :id => 1, :name => "True Value" })
    m_2 = Merchant.new({ :id => 2, :name => "Home Depot" })
    m_3 = Merchant.new({ :id => 3, :name => "Walmart" })
    m_4 = Merchant.new({ :id => 4, :name => "K Mart" })
    mr = MerchantRepository.new([m_1, m_2, m_3, m_4])
    expect(mr.find_by_id(3)).to eq(m_3)
  end

  it 'can find a merchant by name (case insensitive)' do
    m_1 = Merchant.new({ :id => 1, :name => "True Value" })
    m_2 = Merchant.new({ :id => 2, :name => "Home Depot" })
    m_3 = Merchant.new({ :id => 3, :name => "Walmart" })
    m_4 = Merchant.new({ :id => 4, :name => "K Mart" })
    mr = MerchantRepository.new([m_1, m_2, m_3, m_4])
    expect(mr.find_by_name("k MarT")).to eq(m_4)
  end

  it 'can find merchants by name fragment (case insensitive)' do
    m_1 = Merchant.new({ :id => 1, :name => "True Value" })
    m_2 = Merchant.new({ :id => 2, :name => "Home Depot" })
    m_3 = Merchant.new({ :id => 3, :name => "Walmart" })
    m_4 = Merchant.new({ :id => 4, :name => "K Mart" })
    mr = MerchantRepository.new([m_1, m_2, m_3, m_4])
    expect(mr.find_all_by_name("MarT")).to eq([m_3, m_4])
  end

  it 'can find the highest merchant id (helper method)' do
    m_1 = Merchant.new({ :id => 1, :name => "True Value" })
    m_2 = Merchant.new({ :id => 2, :name => "Home Depot" })
    m_3 = Merchant.new({ :id => 3, :name => "Walmart" })
    m_4 = Merchant.new({ :id => 4, :name => "K Mart" })
    mr = MerchantRepository.new([m_1, m_2, m_3, m_4])
    expect(mr.highest_id).to eq(4)
  end

  it 'can create a merchant' do
    m_1 = Merchant.new({ :id => 1, :name => "True Value" })
    m_2 = Merchant.new({ :id => 2, :name => "Home Depot" })
    m_3 = Merchant.new({ :id => 3, :name => "Walmart" })
    m_4 = Merchant.new({ :id => 4, :name => "K Mart" })
    mr = MerchantRepository.new([m_1, m_2, m_3, m_4])
    expect(mr.create(:id => 9000, :name => "Walgreens").class).to eq(Merchant)
  end

  it 'new merchant has highest id' do
    m_1 = Merchant.new({ :id => 1, :name => "True Value" })
    m_2 = Merchant.new({ :id => 2, :name => "Home Depot" })
    m_3 = Merchant.new({ :id => 3, :name => "Walmart" })
    m_4 = Merchant.new({ :id => 4, :name => "K Mart" })
    mr = MerchantRepository.new([m_1, m_2, m_3, m_4])
    binding.pry
    expect(mr.create(:id => 9000, :name => "Walgreens").id).to eq(5)
  end

  it 'can change the name of a merchant' do
    m_1 = Merchant.new({ :id => 1, :name => "True Value" })
    m_2 = Merchant.new({ :id => 2, :name => "Home Depot" })
    m_3 = Merchant.new({ :id => 3, :name => "Walmart" })
    m_4 = Merchant.new({ :id => 4, :name => "K Mart" })
    mr = MerchantRepository.new([m_1, m_2, m_3, m_4])
    expect(mr.update(3, { :id => 3, :name => "Wal-Mart" }).name).to eq("Wal-Mart")
  end

  it 'can delete a merchant' do
    m_1 = Merchant.new({ :id => 1, :name => "True Value" })
    m_2 = Merchant.new({ :id => 2, :name => "Home Depot" })
    m_3 = Merchant.new({ :id => 3, :name => "Walmart" })
    m_4 = Merchant.new({ :id => 4, :name => "K Mart" })
    mr = MerchantRepository.new([m_1, m_2, m_3, m_4])
    mr.delete(4)
    expect(mr.all).to eq([m_1, m_2, m_3])
    mr.delete(3)
    expect(mr.all).to eq([m_1, m_2])
  end

  it 'find a merchant by id from csv' do
    se = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    mr = se.merchants
    expect(mr.find_by_id(12334105).name).to eq("Shopin1901")
  end
end
