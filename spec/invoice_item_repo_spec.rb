require "./lib/merchant_repo"
require "./lib/customer_repo"
require "./lib/invoice_repo"
require "./lib/item_repo"
require "./lib/transaction_repo"
require "./lib/sales_engine"
require "./lib/invoice_item"
require "./lib/invoice_item_repo"
require "pry"

RSpec.describe InvoiceItemRepository do
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
  iir = InvoiceItemRepository.new("./data/invoice_items.csv")

  it "is an instance of InvoiceItemRepository" do
    expect(iir).to be_an_instance_of(InvoiceItemRepository)
  end

  it "can return an array of all invoice item instances" do
    expect(iir.all.count).to eq 1367
  end
end
