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

  xit "can list all instantiated merchants" do
    @merchant_1 = Merchant.new({
                            :id   => 5,
                            :name => "Turing School"
                            })
    @merchant_2 = Merchant.new({
                            :id   => 10,
                            :name => "UGA"
                            })

    # add_merchant(@merchant_1)
    # add_merchant(@merchant_2)

    expect(self.all).to eq([@merchant_1, @merchant_2])
  end

  it "can find a merchant by ID number" do

    expect(Merchant.find_by_id(12334105)).to eq({"created_at"=>"2010-12-10", "id"=>"12334105", "name"=>"Shopin1901", "updated_at"=>"2011-12-04"})
  end

  it 'can find a merchant by name' do
    expect(Merchant.find_by_name("Shopin1901")).to eq({"created_at"=>"2010-12-10", "id"=>"12334105", "name"=>"Shopin1901", "updated_at"=>"2011-12-04"})
    expect(Merchant.find_by_name("SHOPIN1901")).to eq({"created_at"=>"2010-12-10", "id"=>"12334105", "name"=>"Shopin1901", "updated_at"=>"2011-12-04"})
  end
  

end
