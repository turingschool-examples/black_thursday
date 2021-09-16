require "CSV"
require "Rspec"
require_relative "../lib/invoice_repo"
require_relative "../lib/invoice"
require "Time"

describe InvoiceRepo do
  before :each do
    @invoice_repo = InvoiceRepo.new('./data/invoices.csv')
  end

  it "exists" do
    expect(@invoice_repo).to be_an_instance_of(InvoiceRepo)
  end
end
