require "./lib/sales_engine"
require "./lib/item"
require './lib/item_repository'
require "./lib/merchant"
require "./lib/merchant_repository"
require './lib/invoice'
require './lib/invoice_repository'
require './lib/invoice_item'
require './lib/invoice_item_repository'
require './lib/transaction'
require './lib/transaction_repository'
require './lib/customer'
require './lib/customer_repository'


RSpec.describe(SalesEngine) do
  it("#exists") do
    sales_engine = SalesEngine.from_csv(
      {
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
    }
  )
    expect(sales_engine).to(be_instance_of(SalesEngine))
  end

  it("#can return an arrray of all items") do
    sales_engine = SalesEngine.from_csv(
      {
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
    }
  )
    expect(sales_engine.items).to(be_instance_of(ItemRepository))
  end

  it("#can return an array of all merchants") do
    sales_engine = SalesEngine.from_csv(
      {
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
    }
  )
    expect(sales_engine.merchants).to be_a MerchantRepository
    expect(sales_engine.merchants.all).to be_instance_of Array
    expect(sales_engine.merchants.all.length).to eq 475
  end

  it "can create an instance of salesanalyst" do
    sales_engine = SalesEngine.from_csv(
      {
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
    }
  )
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_a(SalesAnalyst)
  end
end
