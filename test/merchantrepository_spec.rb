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

  xit "can list all instantiated merchants" do


    expect(MerchantRepository.all).to be_a(Hash)
  end

  xit "can find a merchant by ID number" do

    expect(MerchantRepository.find_by_id(12334105)).to eq({"created_at"=>"2010-12-10", "id"=>"12334105", "name"=>"Shopin1901", "updated_at"=>"2011-12-04"})
    expect(MerchantRepository.find_by_id(12334112)).to eq({"created_at"=>"2009-05-30", "id"=>"12334112", "name"=>"Candisart", "updated_at"=>"2010-08-29"})
  end

  xit 'can find a merchant by name' do

    expect(MerchantRepository.find_by_name("Shopin1901")).to eq([{"created_at"=>"2010-12-10", "id"=>"12334105", "name"=>"SHOPIN1901", "updated_at"=>"2011-12-04"}])
    expect(MerchantRepository.find_by_name("shopin1901")).to eq([{"created_at"=>"2010-12-10", "id"=>"12334105", "name"=>"SHOPIN1901", "updated_at"=>"2011-12-04"}])
    expect(MerchantRepository.find_by_name("SHOPIN1901")).to eq([{"created_at"=>"2010-12-10", "id"=>"12334105", "name"=>"SHOPIN1901", "updated_at"=>"2011-12-04"}])
    expect(MerchantRepository.find_by_name("Candisart")).to eq([{"created_at"=>"2009-05-30", "id"=>"12334112", "name"=>"CANDISART", "updated_at"=>"2010-08-29"}])
  end

  xit 'finds all by name' do

    expect(MerchantRepository.find_all_by_name("shop")).to eq([{"created_at"=>"2010-12-10", "id"=>"12334105", "name"=>"SHOPIN1901", "updated_at"=>"2011-12-04"},
      {"created_at"=>"2008-12-20", "id"=>"12334176", "name"=>"THEPURPLEPENSHOP", "updated_at"=>"2012-06-25"}])
    expect(MerchantRepository.find_all_by_name("PinkBow")).to eq ([{"created_at"=>"2004-11-19", "id"=>"12334149", "name"=>"THELILPINKBOWTIQUE", "updated_at"=>"2014-01-17"}])
  end

  xit 'creates' do
    expect(MerchantRepository.create("OurStore", "2020-12-10", "2021-03-20")).to be_an_instance_of(Merchant)
    # expect(Merchant.create("OurStore", "2020-12-10", "2021-03-20")).to eq("created_at"=>"2020-12-10", "id"=>"12334203", "name"=>"OurStore", "updated_at"=>"2021-03-20")
  end



end
