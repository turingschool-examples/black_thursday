require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe InvoiceRepository do
  let!(:sales_engine) {SalesEngine.from_csv({:invoices => "./data/invoices.csv"})}
  let!(:invoice_repo) {sales_engine.invoices}
  let(:new_invoice) {invoice_repo.create({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
  })}

  it "exists" do
    expect(invoice_repo).to be_instance_of InvoiceRepository
  end

  it "can return all invoice instances in an array" do
    expect(invoice_repo.all).to be_a Array
  end

  it "can find invoices by their id" do
    expect(invoice_repo.find_all_by_id(10)).to be_instance_of Invoice
    expect(invoice_repo.find_all_by_id(10).customer_id).to eq(2)
  end

  it "can find invoices by their customer_id" do
    expect(invoice_repo.find_all_by_customer_id(0)).to eq([])
    expect(invoice_repo.find_all_by_customer_id(2)[0]).to be_instance_of Invoice
    expect(invoice_repo.find_all_by_customer_id(2).count).to eq(4)
  end

  it "can find invoices by their merchant_id" do
    expect(invoice_repo.find_all_by_merchant_id(0)).to eq([])
    expect(invoice_repo.find_all_by_merchant_id(12334839)[0]).to be_instance_of Invoice
    expect(invoice_repo.find_all_by_merchant_id(12334839).count).to eq(9)
  end

  it "can find invoices by status" do
    expect(invoice_repo.find_all_by_status("delivered")).to eq([])
    expect(invoice_repo.find_all_by_status("shipped")[0]).to be_instance_of Invoice
    expect(invoice_repo.find_all_by_status("shipped").count).to eq(2839)
  end

  it "can create a new invoice" do
    expect(invoice_repo.find_all_by_merchant_id(8)).to eq([])
    new_invoice
    expect(invoice_repo.find_all_by_merchant_id(8)[0]).to be_instance_of Invoice
  end
end
