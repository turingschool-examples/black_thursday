require 'RSpec'
require './lib/merchant'

describe Merchant do

  it "exists and has attributes" do
    merchant = Merchant.new({:id => 5, :name=> "Turing"})

    expect(merchant).to be_a Merchant
    expect(merchant.id).to eq(5)
    expect(merchant.name).to eq("Turing")
  end
end
