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
    expect(@sales_engine.items).to be_instance_of ItemRepository
  end

  it "can return an array of all merchants" do

    expect(@sales_engine.merchants).to be_instance_of MerchantRepository
  end

  it "can return an array of all invoices" do
    expect(@sales_engine.invoices).to be_instance_of InvoiceRepository
  end

  it "can return an array of all customers" do
    expect(@sales_engine.customers).to be_instance_of CustomerRepository
  end
  it "can return an array of all transactions" do
    expect(@sales_engine.transactions).to be_instance_of TransactionRepository
  end

end
