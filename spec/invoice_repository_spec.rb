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
    
    expect(@invoice_repository.all.first.customer_id).to eq(2)
  end
end
