require 'rspec'
require 'csv'
require './lib/merchant'

RSpec.describe 'Merchant' do
  it "exists" do
    @merchant_1 = Merchant.new({
                            :id   => 12334105,
                            :name => "Shopin1901",
                            :created_at => "2010-12-10",
                            :updated_at => "2011-12-04"
                            })
    expect(@merchant_1).to be_a Merchant

  end

  it "has readable info" do
    @merchant_1 = Merchant.new({
                            :id   => 12334105,
                            :name => "Shopin1901",
                            :created_at => "2010-12-10",
                            :updated_at => "2011-12-04"
                            })
    expect(@merchant_1.id).to eq(12334105)
    expect(@merchant_1.name).to eq("Shopin1901")
  end
end
