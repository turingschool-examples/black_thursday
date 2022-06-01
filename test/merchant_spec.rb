# require "./lib/sales_engine"
# require "./lib/item_collection"
# require "./lib/merchant_collection"
require "./lib/merchant"

#add more `expect` lines to each test to make it more robust...!
RSpec.describe Merchant do
  it "exists" do
    merchant = Merchant.new({:id => 5, :name => "Turing School"})
    expect(merchant).to be_instance_of Merchant
  end
end
