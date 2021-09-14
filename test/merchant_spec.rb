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
    expect(Merchant.find_by_id(12334105)).to eq("Shopin1901")

  end

end
