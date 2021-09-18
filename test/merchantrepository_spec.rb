require 'rspec'
require 'csv'
require './lib/merchant'
require './lib/merchantrepository0'
require './lib/sales_engine'
# require './lib/sales_engine'

RSpec.describe 'MerchantRepository' do
  before (:each) do

  end
  # xit "exists" do
  #
  #   mr = MerchantRepository.new()#({
  #   #                                                 id: 12334135,
  #   #                                                 name: "GoldenRayPress",
  #   #                                                 created_at: "2011-12-13",
  #   #                                                 updated_at: "2012-04-16"
  #   #                                               })
  #
  #   expect(mr).to be_a(MerchantRepository)
  # end
  #
  # xit "can list all instantiated merchants" do
  #
  #   expect(MerchantRepository.all).to be_a(Array)
  # end

  it "can find a merchant by ID number" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    mr = se.merchants

    expect(mr).to be_a(MerchantRepository)
    expect(mr.find_by_id(12334146)).to be_a(Merchant)
  end

  xit 'can find a merchant by name' do

    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    mr = se.merchants

    expect(mr.find_by_name("Shopin1901")).to be_a(Merchant)
    expect(mr.find_by_name("fancybookart")).to be_a(Merchant)

  end

  xit 'finds all by name' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    mr = se.merchants

    expect(mr.find_all_by_name("shop")).to include({:created_at=>"2010-12-10", :id=>12334105, :name=>"SHOPIN1901", :updated_at=>"2011-12-04"},
       {:created_at=>"2008-12-20", :id=>12334176, :name=>"THEPURPLEPENSHOP", :updated_at=>"2012-06-25"})
    expect(mr.find_all_by_name("PinkBow")).to include({:created_at=>"2004-11-19", :id=>12334149, :name=>"THELILPINKBOWTIQUE", :updated_at=>"2014-01-17"})
  end

  xit 'creates' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    mr = se.merchants
    mr.create("OurStore", "2020-12-10", "2021-03-20")

    expect(mr.find_by_id(12337413)).to eq({:created_at=>"2020-12-10", :id=>12337412, :name=>"OURSTORE", :updated_at=>"2021-03-20"})

  end

  it "can update the name of merchants" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    mr = se.merchants

    expect(mr.update(12334149, "Bluebow")).to eq({:created_at=>"2004-11-19", :id=>12334149, :name=>"Bluebow", :updated_at=>"2014-01-17"})

  end

  it "can delete merchants" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    mr = se.merchants

    mr.delete(12334203)

    expect(mr.find_by_id(12334203)).to eq(nil)
  end
end
