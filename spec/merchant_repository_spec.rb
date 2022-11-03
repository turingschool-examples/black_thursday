require 'rspec'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

RSpec.describe MerchantRepository do
  it 'can return an array of Merchant instances' do
    mr = MerchantRepository.new

    expect(mr.all).to eq([])
  end

  describe '#add_merchant' do
    it 'adds merchant instances to all array' do
      mr = MerchantRepository.new
      m = Merchant.new({:id => 5, :name => "Turing School"})
      mr.add_merchant(m)

      expect(mr.all).to eq([m])
    end
  end

  describe '#find_by_id' do

    it 'returns either nil or an instance of Merchant with a matching ID' do
      mr = MerchantRepository.new
      m = Merchant.new({:id => 5, :name => "Turing School"})
      m2 = Merchant.new({:id => 2, :name => "Other School"})
      mr.add_merchant(m)
      mr.add_merchant(m2)

      expect(mr.find_by_id(5)).to eq(m)
      expect(mr.find_by_id(1)).to eq(nil)
      expect(mr.find_by_id(2)).to eq(m2)
      expect(mr.find_by_id(7)).to eq(nil)

    end
  end

  it 'returns either nil or an instance of Merchant having done a case insensitive search' do
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 2, :name => "Other School"})
    mr.add_merchant(m)
    mr.add_merchant(m2)

    expect(mr.find_by_name("TuRing School")).to eq(m)
    expect(mr.find_by_name("the other other school")).to eq(nil)

  end

  it 'can find all instances of a merchant' do
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 7, :name => "Turing School"})
    m3 = Merchant.new({:id => 2, :name => "Other School"})
    mr.add_merchant(m)
    mr.add_merchant(m2)
    mr.add_merchant(m3)


    expect(mr.find_all_by_name("turing School")).to eq([m, m2])
    expect(mr.find_all_by_name("tuRing ScHool")).to eq([m, m2])
    expect(mr.find_all_by_name("the other other School")).to eq([])


  end

  it 'creates a new merchant with the attributes provided with a new highest id' do
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 7, :name => "Turing School"})
    m3 = Merchant.new({:id => 2, :name => "Other School"})
    mr.add_merchant(m)
    mr.add_merchant(m2)
    mr.add_merchant(m3)

    m4 = mr.create({:name => "other other school"})
    #require 'pry'; binding.pry
    expect(m4.id).to eq(8)
    expect(m4.name).to eq("other other school")
  end

  describe '#update' do
    it 'updates only the name of the merchant object with the given id' do
      mr = MerchantRepository.new
      m = Merchant.new({:id => 5, :name => "Turing School"})
      m2 = Merchant.new({:id => 7, :name => "Turing School"})
      m3 = Merchant.new({:id => 2, :name => "Other School"})
      mr.add_merchant(m)
      mr.add_merchant(m2)
      mr.add_merchant(m3)
      mr.update(7, "Cool School")

      expect(m2.name).to eq("Cool School")
    end
  end
  describe '#delete' do
    it 'deleted the merchant object with the corresponding id' do
      mr = MerchantRepository.new
      m = Merchant.new({:id => 5, :name => "Turing School"})
      m2 = Merchant.new({:id => 7, :name => "Turing School"})
      m3 = Merchant.new({:id => 2, :name => "Other School"})
      mr.add_merchant(m)
      mr.add_merchant(m2)
      mr.add_merchant(m3)
      mr.delete(7)

      expect(mr.all).to eq([m, m3])
    end
  end

  it 'can load data' do
    mr = MerchantRepository.new
    file = "./data/merchants.csv"
    mr.load_data(file)
    # require 'pry' ; binding.pry

    expect(mr.all.first).to be_a(Merchant)
    expect(mr.all.all?(Merchant)).to eq(true)


  end
end
