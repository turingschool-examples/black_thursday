require 'csv'
require 'pry'
require 'invoice'
require 'invoice_repository'

RSpec.describe InvoiceRepository do
  before :each do
    @invoice_repository = InvoiceRepository.new("./data/invoices.csv")
  end

  it "exists" do
    expect(@invoice_repository).to be_a InvoiceRepository
  end

  it "can return an array of all known invoices" do
    expect(@invoice_repository.all).to be_a Array
    expect(@invoice_repository.all.length).to eq(4985)
    expect(@invoice_repository.all.first).to be_a Invoice
    expect(@invoice_repository.all.first.id).to eq("1")
    expect(@invoice_repository.all.first.merchant_id).to eq("12335938")
  end

  it "can find an invoice by id and return nil if not found" do
    expect(@invoice_repository.find_by_id(0)).to eq nil
    expect(@invoice_repository.find_by_id(11)).to be_a(Invoice)
    expect(@invoice_repository.find_by_id(370)).to be_a(Invoice)
  end

  it "can find an invoice by customer id and return an array if one or more matches found" do
    expect(@invoice_repository.find_all_by_customer_id(205)).to be_a(Array)
    expect(@invoice_repository.find_all_by_customer_id(400)).to be_a(Array)
    expect(@invoice_repository.find_all_by_customer_id(0)).to eq ([])
  end

  it "can find a merchant by id and return an array if one or more matches found" do
    expect(@invoice_repository.find_all_by_merchant_id(12336965)).to be_a(Array)
    expect(@invoice_repository.find_all_by_merchant_id(12334444)).to be_a(Array)
    expect(@invoice_repository.find_all_by_merchant_id(1)).to eq([])
  end

  it "can find all by status and return an array" do
    expect(@invoice_repository.find_all_by_status("pending")).to be_a(Array)
    expect(@invoice_repository.find_all_by_status("shipped")).to be_a(Array)
    expect(@invoice_repository.find_all_by_status("returned")).to be_a(Array)
    expect(@invoice_repository.find_all_by_status("no status")).to eq([])
  end
  it "can create new invoices" do
    @invoice_repository.create({:customer_id => 1, :merchant_id => 12334105, :status => "pending", :created_at => Time.now, :updated_at => Time.now})
    expect(@invoice_repository.all.last).to be_a Invoice
    expect(@invoice_repository.all.length).to eq(4986)
    expect(@invoice_repository.all.last.customer_id).to eq(4986)
    expect(@invoice_repository.all.last.status).to eq("pending")
  end
  it "can can update invoice instances with new status and time "do
  @invoice_repository.update(1, "shipped")
  expect(@invoice_repository.find_by_id(1).status).to eq("shipped")
  end
  it "can delete the invoice instance" do
    @invoice_repository.delete(1)

    expect(@invoice_repository.all.first.id).to eq("2")
  end
end
