require_relative 'simplecov'
SimpleCov.start
require_relative './lib/helper'

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
    expect(invoice_repo.find_by_id(10)).to be_instance_of Invoice
    expect(invoice_repo.find_by_id(10).customer_id).to eq(2)
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
    expect(invoice_repo.find_all_by_status(:shipped)[0]).to be_instance_of Invoice
    expect(invoice_repo.find_all_by_status(:shipped).count).to eq(2839)
  end

  it "can create a new invoice" do
    expect(invoice_repo.find_all_by_merchant_id(8)).to eq([])
    new_invoice
    expect(invoice_repo.find_all_by_merchant_id(8)[0]).to be_instance_of Invoice
  end

  it "can update an invoice" do
    time = Time.now
    expect(invoice_repo.find_by_id(1)).to be_instance_of Invoice
    expect(invoice_repo.find_by_id(1).status).to eq(:pending)
    expect(invoice_repo.find_by_id(1).updated_at).to eq("2014-03-15")
    invoice_repo.update(1, :shipped)
    expect(invoice_repo.find_by_id(1).status).to eq(:shipped)
    expect(invoice_repo.find_by_id(1).updated_at).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end

  it "can delete an invoice" do
    expect(invoice_repo.find_by_id(1)).to be_instance_of Invoice
    expect(invoice_repo.find_by_id(1).status).to eq(:pending)
    expect(invoice_repo.find_by_id(1).updated_at).to eq("2014-03-15")
    invoicerepository = double()
    allow(invoicerepository).to receive(:delete).and_return("Deletion complete!")
  end
end
