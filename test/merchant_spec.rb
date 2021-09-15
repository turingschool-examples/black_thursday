require 'rspec'
require 'csv'
require './lib/merchant'
# require './lib/sales_engine'

RSpec.describe 'Merchant' do
  before(:each) do

  end


  it "exists" do
    @merchant_1 = Merchant.new({
                            :id   => 5,
                            :name => "Turing School"
                            })
    expect(@merchant_1).to be_a Merchant
  end

  it "has readable info" do
    @merchant_1 = Merchant.new({
                            :id   => 5,
                            :name => "Turing School"
                            })
    expect(@merchant_1.id).to eq(5)
    expect(@merchant_1.name).to eq("Turing School")
  end

  it "can list all instantiated merchants" do

    expected = [["id", "12334105", "name", "Shopin1901", "created_at", "2010-12-10", "updated_at", "2011-12-04"],
     ["id", "12334112", "name", "Candisart", "created_at", "2009-05-30", "updated_at", "2010-08-29"],
     ["id", "12334113", "name", "MiniatureBikez", "created_at", "2010-03-30", "updated_at", "2013-01-21"],
     ["id", "12334115", "name", "LolaMarleys", "created_at", "2008-06-09", "updated_at", "2015-04-16"],
     ["id", "12334123", "name", "Keckenbauer", "created_at", "2010-07-15", "updated_at", "2012-07-25"],
     ["id", "12334132", "name", "perlesemoi", "created_at", "2009-03-21", "updated_at", "2014-05-19"],
     ["id", "12334135", "name", "GoldenRayPress", "created_at", "2011-12-13", "updated_at", "2012-04-16"],
     ["id", "12334141", "name", "jejum", "created_at", "2007-06-25", "updated_at", "2015-09-09"],
     ["id", "12334144", "name", "Urcase17", "created_at", "2000-03-28", "updated_at", "2006-03-25"],
     ["id", "12334145", "name", "BowlsByChris", "created_at", "2003-01-14", "updated_at", "2005-03-11"],
     ["id", "12334146", "name", "MotankiDarena", "created_at", "2006-02-04", "updated_at", "2016-02-01"],
     ["id", "12334149", "name", "TheLilPinkBowtique", "created_at", "2004-11-19", "updated_at", "2014-01-17"],
     ["id", "12334155", "name", "DesignerEstore", "created_at", "2013-01-16", "updated_at", "2014-02-17"],
     ["id", "12334159", "name", "SassyStrangeArt", "created_at", "2002-11-18", "updated_at", "2007-10-09"],
     ["id", "12334160", "name", "byMarieinLondon", "created_at", "2009-01-18", "updated_at", "2011-05-04"],
     ["id", "12334165", "name", "JUSTEmonsters", "created_at", "2009-12-25", "updated_at", "2013-11-25"],
     ["id", "12334174", "name", "Uniford", "created_at", "2000-01-26", "updated_at", "2002-01-19"],
     ["id", "12334176", "name", "thepurplepenshop", "created_at", "2008-12-20", "updated_at", "2012-06-25"],
     ["id", "12334183", "name", "handicraftcallery", "created_at", "2002-03-30", "updated_at", "2012-05-18"],
     ["id", "12334185", "name", "Madewithgitterxx", "created_at", "2000-09-22", "updated_at", "2011-07-20"],
     ["id", "12334189", "name", "JacquieMann", "created_at", "2003-11-09", "updated_at", "2013-01-12"],
     ["id", "12334193", "name", "TheHamAndRat", "created_at", "2011-10-09", "updated_at", "2015-06-19"],
     ["id", "12334194", "name", "Lnjewelscreation", "created_at", "2002-01-10", "updated_at", "2016-02-20"],
     ["id", "12334195", "name", "FlavienCouche", "created_at", "2001-06-24", "updated_at", "2002-02-26"],
     ["id", "12334202", "name", "VectorCoast", "created_at", "2006-07-15", "updated_at", "2007-12-05"]]

    expect(Merchant.all).to eq(expected)
  end

  xit "can find a merchant by ID number" do

    expect(Merchant.find_by_id(12334105)).to eq({"created_at"=>"2010-12-10", "id"=>"12334105", "name"=>"Shopin1901", "updated_at"=>"2011-12-04"})
    expect(Merchant.find_by_id(12334112)).to eq(nil)
  end

  xit 'can find a merchant by name' do
    expect(Merchant.find_by_name("Shopin1901")).to eq({"created_at"=>"2010-12-10", "id"=>"12334105", "name"=>"Shopin1901", "updated_at"=>"2011-12-04"})
    expect(Merchant.find_by_name("SHOPIN1901")).to eq({"created_at"=>"2010-12-10", "id"=>"12334105", "name"=>"Shopin1901", "updated_at"=>"2011-12-04"})
    expect(Merchant.find_by_name("Candisart")).to eq(nil)
  end


end
