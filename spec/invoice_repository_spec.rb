require "./lib/invoice_repository"
require "rspec"

RSpec.describe InvoiceRepository do
  it "exists" do
    invoice_repo = InvoiceRepository.new
    expect(invoice_repo).to be_a(InvoiceRepository)
  end
  it "can find all by status" do
    expect(invoice_repo.find_all_by_status(pending)).to eq([])
    expect(invoice_repo.find_all_by_status(shipped)).to eq([])
    
  end
  
end 
