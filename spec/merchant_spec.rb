require './lib/merchant'

RSpec.describe Merchant do
  before :each do
    @merchant = Merchant.new({:id => 5, :name => "Turing School"})
  end

  it "exists" do
    expect(@merchant).to be_a(Merchant)
  end



end
