require './lib/sales_engine'
require 'pry'

describe SalesEngine do
  se = SalesEngine.from_csv({
    :items => './data/items.csv',
    :merchants => './data/merchants.csv'
    })

    # binding.pry
    mr = se.merchants
    ir = se.items

  it "creates Items and Merchants classes" do
    # expect(se).to be_an_instance_of(SalesEngine)
    expect(ir).to be_an_instance_of(ItemRepository)
    expect(mr).to be_an_instance_of(MerchantRepository)
  end
end
