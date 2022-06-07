require_relative 'simplecov'
SimpleCov.start
require_relative './lib/helper'

RSpec.describe InvoiceItemRepository do
  let!(:sales_engine) {SalesEngine.from_csv({:invoice_items => "./data/invoice_items.csv"})}
  let!(:invoice_items_repo) {sales_engine.invoice_items}
  let(:new_invoice_item) {invoice_items_repo.make_invoice_item({
    :id => 0,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => "17.99",
    :created_at => "2011-09-10",
    :updated_at => "2012-05-08"
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
    expect(invoice_items_repo.find_all_by_invoice_id(8).first.id).to eq(38)
  end

  xit "can update an invoice item" do
    time = Time.now
    new_invoice_item
    expect(invoice_items_repo.find_by_id(21831)).to be_instance_of InvoiceItem
    expect(invoice_items_repo.find_by_id(21831).item_id).to eq(7)
    expect(invoice_items_repo.find_by_id(21831).quantity).to eq(1)
    # expect(invoice_items_repo.find_by_id(21831).updated_at.strftime("%Y-%m-%d %H:%M")).to eq(invoice_items_repo.find_by_id(21831).created_at.strftime("%Y-%m-%d %H:%M"))

    invoice_items_repo.update(21831, {:quantity => 200, :unit_price => "14.99"})
    expect(invoice_items_repo.find_by_id(21831).item_id).to eq(7)
    expect(invoice_items_repo.find_by_id(21831).quantity).to eq(2)
    expect(invoice_items_repo.find_by_id(21831).unit_price).to eq("14.99")
    # expect(invoice_items_repo.find_by_id(21831).updated_at).to eq(time.strftime("%Y-%m-%d %H:%M"))
    # expect(invoice_items_repo.find_by_id(1).updated_at).not_to eq(invoice_items_repo.find_by_id(21831).created_at)
  end

  it "can delete an invoice" do
    new_invoice_item
    expect(invoice_items_repo.find_by_id(21831)).to be_instance_of InvoiceItem
    expect(invoice_items_repo.find_by_id(21831).quantity).to eq(1)
    # expect(invoice_items_repo.find_by_id(1).updated_at).to eq("2014-03-15")
    invoicerepository = double()
    allow(invoicerepository).to receive(:delete).and_return("Deletion complete!")
  end
end
