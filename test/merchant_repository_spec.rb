require "./lib/sales_engine"
require "./lib/merchant_repository"
require "./lib/item_repository"
# require "./lib/merchant"

RSpec.describe MerchantRepository do
  it "exists" do
    sales_engine = SalesEngine.from_csv({:items => "./data/items.csv",:merchants => "./data/merchants.csv"})

    merchant_repository = sales_engine.merchant_repository
    require 'pry'; binding.pry
    merchant = merchant_repository.find(34)
    expect(merchant).to be(Merchant)
    # => <Merchant>
    merchants = merchant_repository.all
    expect(merchants).to be(Merchant)
    # => [<Merchant>, <Merchant>...]
  end
end
