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
end
