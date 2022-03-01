require "csv"
require './lib/sales_engine'
require "./lib/merchant"
require "./lib/item"
require "./lib/invoice"
require "./lib/customer"
require 'pry'

RSpec.describe SalesEngine do

  se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv"
  })

  it "exists" do
    se.analyst
    expect(se).to be_an_instance_of(SalesEngine)

  end

  it "returns merchants, items, invoices, customers" do
    expect(se.items_repo).to be_an_instance_of(ItemRepository)
    expect(se.merchants_repo).to be_an_instance_of(MerchantRepository)
    expect(se.invoices_repo).to be_an_instance_of(InvoiceRepository)
    expect(se.customers_repo).to be_an_instance_of(CustomerRepository)
  end

end
