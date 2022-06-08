require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'

RSpec.describe SalesEngine do
  before :each do
    @sales_engine = SalesEngine.from_csv(
      {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :customers => "./data/customers.csv",
      :transactions => "./data/transactions.csv"
      }
    )
  end

  it "exists" do
    expect(@sales_engine).to be_instance_of SalesEngine
  end

  it "can return an array of all items" do
    expect(@sales_engine.item_repository).to be_instance_of ItemRepository
  end

  it "can return an array of all merchants" do

    expect(@sales_engine.merchant_repository).to be_instance_of MerchantRepository
  end

  it "can return an array of all invoices" do
    expect(@sales_engine.invoice_repository).to be_instance_of InvoiceRepository
  end

  it "can return an array of all customers" do
    expect(@sales_engine.customer_repository).to be_instance_of CustomerRepository
  end
end
