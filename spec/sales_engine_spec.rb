require './lib/merchant_repository'
require './lib/merchant'
require './lib/item_repository'
require './lib/item'
require './lib/sales_engine'
require './lib/sales_analyst'
require './lib/invoice_repository'
require './lib/invoice'
require './lib/invoice_item_repository'
require './lib/transaction_repository'
require './lib/customer_repository'
require 'CSV'

RSpec.describe SalesEngine do
  before :each do
    @salesengine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
  end

  it "exists" do
    expect(@salesengine).to be_a(SalesEngine)
    expect(@salesengine.analyst).to be_a(SalesAnalyst)
  end

  it "can return an array of all items" do
    expect(@salesengine.item_repository).to be_instance_of ItemRepository
  end

  it "can return an array of all merchants" do
    expect(@salesengine.merchant_repository).to be_instance_of MerchantRepository
  end

  it "can return merchants, items. invoices, transactions, and customers" do
    expect(@salesengine.merchants).to be_instance_of MerchantRepository
    expect(@salesengine.items).to be_instance_of ItemRepository
    expect(@salesengine.invoices).to be_instance_of InvoiceRepository
    expect(@salesengine.invoice_items).to be_instance_of InvoiceItemRepository
    expect(@salesengine.transactions).to be_instance_of TransactionRepository
    expect(@salesengine.customers).to be_instance_of CustomerRepository
  end
end
