require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe InvoiceItemRepository do
  let!(:sales_engine) {SalesEngine.from_csv({:invoice_items => "./data/invoice_items.csv"})}
  let!(:invoice_items_repo) {sales_engine.invoice_items}
  let(:new_invoice_item) {invoice_items_repo.make_invoice_item({
    :id => 0,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
  })}

  it "exists" do
    expect(invoice_items_repo).to be_instance_of InvoiceItemRepository
  end

  it "can return all invoice item instances in an array" do
    expect(invoice_items_repo.all).to be_a Array
  end

  it "can find invoices items by their id" do
    new_invoice_item
    expect(invoice_items_repo.find_by_id(21831)).to be_instance_of InvoiceItem
    expect(invoice_items_repo.find_by_id(21831).item_id).to eq(7)
  end

  it "can find all invoice items by their item id" do
    new_invoice_item
    expect(invoice_items_repo.find_all_by_item_id(263519844).first).to be_instance_of InvoiceItem
    expect(invoice_items_repo.find_all_by_item_id(263519844).first.id).to eq(1)
  end

  it "can find invoice items by their invoice id" do
    expect(invoice_items_repo.find_all_by_invoice_id(8).first).to be_instance_of InvoiceItem
    expect(invoice_items_repo.find_all_by_invoice_id(8).first.invoice_id).to eq(2)
  end

  xit "can create a new invoice" do
    expect(invoice_items_repo.find_all_by_merchant_id(8)).to eq([])
    new_invoice_item
    expect(invoice_items_repo.find_all_by_merchant_id(8)[0]).to be_instance_of InvoiceItem
  end

  xit "can update an invoice" do
    time = Time.now
    expect(invoice_items_repo.find_by_id(1)).to be_instance_of InvoiceItem
    expect(invoice_items_repo.find_by_id(1).status).to eq("pending")
    expect(invoice_items_repo.find_by_id(1).updated_at).to eq("2014-03-15")
    invoice_items_repo.update(1, "shipped")
    expect(invoice_items_repo.find_by_id(1).status).to eq("shipped")
    expect(invoice_items_repo.find_by_id(1).updated_at).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end

  xit "can delete an invoice" do
    expect(invoice_items_repo.find_by_id(1)).to be_instance_of InvoiceItem
    expect(invoice_items_repo.find_by_id(1).status).to eq("pending")
    expect(invoice_items_repo.find_by_id(1).updated_at).to eq("2014-03-15")
    invoicerepository = double()
    allow(invoicerepository).to receive(:delete).and_return("Deletion complete!")
  end
end
