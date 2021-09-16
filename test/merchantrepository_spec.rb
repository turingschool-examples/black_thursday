require 'rspec'
require 'csv'
require './lib/merchant'
require './lib/merchantrepository'
# require './lib/sales_engine'

RSpec.describe 'MerchantRepository' do
  it "exists" do
    @merchant_repository = MerchantRepository.new

    expect(@merchant_repository).to be_a(MerchantRepository)

  end

  it "can list all instantiated merchants" do


    expect(MerchantRepository.all).to be_a(Array)
  end

  it "can find a merchant by ID number" do
    #require "pry"; binding.pry
    expect(MerchantRepository.find_by_id(12334105)).to eq({:created_at=>"2010-12-10", :id=>12334105, :name=>"Shopin1901", :updated_at=>"2011-12-04"})
    expect(MerchantRepository.find_by_id(12334112)).to eq({:created_at=>"2009-05-30", :id=>12334112, :name=>"Candisart", :updated_at=>"2010-08-29"})
    expect(MerchantRepository.find_by_id(12334160)).to eq({:created_at=>"2009-01-18", :id=>12334160, :name=>"byMarieinLondon", :updated_at=>"2011-05-04"})
  end

  it 'can find a merchant by name' do

    expect(MerchantRepository.find_by_name("Shopin1901")).to eq([{:created_at=>"2010-12-10", :id=>12334105, :name=>"SHOPIN1901", :updated_at=>"2011-12-04"}])
    expect(MerchantRepository.find_by_name("shopin1901")).to eq([{:created_at=>"2010-12-10", :id=>12334105, :name=>"SHOPIN1901", :updated_at=>"2011-12-04"}])
    expect(MerchantRepository.find_by_name("SHOPIN1901")).to eq([{:created_at=>"2010-12-10", :id=>12334105, :name=>"SHOPIN1901", :updated_at=>"2011-12-04"}])
    expect(MerchantRepository.find_by_name("Candisart")).to eq([{:created_at=>"2009-05-30", :id=>12334112, :name=>"CANDISART", :updated_at=>"2010-08-29"}])
  end

  it 'finds all by name' do

    expect(MerchantRepository.find_all_by_name("shop")).to eq([{:created_at=>"2010-12-10", :id=>12334105, :name=>"SHOPIN1901", :updated_at=>"2011-12-04"},
       {:created_at=>"2008-12-20", :id=>12334176, :name=>"THEPURPLEPENSHOP", :updated_at=>"2012-06-25"}])
    expect(MerchantRepository.find_all_by_name("PinkBow")).to eq ([{:created_at=>"2004-11-19", :id=>12334149, :name=>"THELILPINKBOWTIQUE", :updated_at=>"2014-01-17"}])
  end

  it 'creates' do
    MerchantRepository.create("OurStore", "2020-12-10", "2021-03-20")

    expect(MerchantRepository.find_by_id(12334203)).to eq({:created_at=>"2020-12-10", :id=>12334203, :name=>"OURSTORE", :updated_at=>"2021-03-20"})

  end

  it "can update the name of merchants" do
    expect(MerchantRepository.update(12334149, "Bluebow")).to eq({:created_at=>"2004-11-19", :id=>12334149, :name=>"Bluebow", :updated_at=>"2014-01-17"})
  end

  it "can delete merchants" do
    MerchantRepository.delete(12334203)

    expect(MerchantRepository.find_by_id(12334203)).to eq(nil)
  end
end
