require "csv"
require "./lib/sales_engine"
require "./lib/merchant"
require "./lib/item"
require "./lib/invoice"
require "./lib/customer"
require "./lib/transaction"
require "./lib/invoice_item"
require "pry"

RSpec.describe SalesEngine do
  let(:se) do
    SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      customers: "./data/customers.csv",
      transactions: "./data/transactions.csv",
      invoice_items: "./data/invoice_items.csv"
    })
  end

  it "exists" do
    se.analyst
    expect(se).to be_an_instance_of(SalesEngine)
  end

  it "returns relevant instances of all repositories" do
    expect(se.items_repo).to be_an_instance_of(ItemRepository)
    expect(se.merchants_repo).to be_an_instance_of(MerchantRepository)
    expect(se.invoices_repo).to be_an_instance_of(InvoiceRepository)
    expect(se.customers_repo).to be_an_instance_of(CustomerRepository)
    expect(se.transactions_repo).to be_an_instance_of(TransactionRepository)
    expect(se.invoice_items_repo).to be_an_instance_of(InvoiceItemRepository)
  end
end
