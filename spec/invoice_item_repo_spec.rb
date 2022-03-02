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

  it "returns an array of all invoice item instances" do
    expect(iir.all.count).to eq 21830
  end

  it "finds an invoice item by id" do
    expected_item = iir.find_by_id(20)
    expect(expected_item.invoice_item_attributes[:item_id]).to eq 263395237
    expect(expected_item.invoice_item_attributes[:unit_price]).to eq 72018
  end

  it "finds all invoice items by item id" do
    expected_items = iir.find_all_by_item_id(263563764)
    expect(expected_items.length).to eq(16)
  end

  it "finds all invoice items by invoice id" do
    expected_items = iir.find_all_by_invoice_id(9)
    expect(expected_items.length).to eq(3)
  end

  it "creates a new invoice item" do
    iir.create({item_id: 999999999})
    expected_invoice_item = iir.find_by_id(21831)
    expect(expected_invoice_item.invoice_item_attributes[:id]).to eq(21831)
  end

  it "updates an invoice item" do
    iir.create({quantity: 999, unit_price: 99999})
    iir.update(21831, {quantity: 111, unit_price: 11111})
    expected_item_invoice = iir.find_by_id(21831)
    expect(expected_item_invoice.invoice_item_attributes[:quantity]).to eq(111)
    expect(expected_item_invoice.invoice_item_attributes[:unit_price]).to eq(11111)
  end

  it "deletes an invoice item" do
    iir.create({quantity: 999})
    iir.delete(21831)
    expect(iir.find_by_id(21831)).to eq nil
  end
end
