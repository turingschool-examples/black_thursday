require "./lib/invoice_repository"
require "./lib/invoice"
require "rspec"

RSpec.describe InvoiceRepository do
  before (:each) do
    invoice1 = double(:id =>4,:customer_id =>1,:merchant_id =>12334269,:status => pending,:created_at =>2013-08-05,:updated_at =>2014-06-06)
    invoice2 = double(:id =>5,:customer_id =>2,:merchant_id =>12334269,:status => pending,:created_at =>2014-02-08,:updated_at =>2014-07-22)
    invoice3 = double(:id =>12,:customer_id =>1,:merchant_id =>12336617,:status => shipped,:created_at =>2014-05-06,:updated_at =>2014-10-06)
    invoice_repo = InvoiceRepository.new([invoice1, invoice2, invoice3])
  end
   
  it "exists" do
    expect(invoice_repo).to be_a(InvoiceRepository)
  end
  it "can find all by status" do
    expect(invoice_repo.find_all_by_status(pending)).to eq([invoice1,invoice2])
    expect(invoice_repo.find_all_by_status(shipped)).to eq([invoice3])
    
  end
  it "can find all by merchant_id" do
    expect(invoice_repo.find_all_by_merchant_id(12334269)).to eq([invoice1, invoice2])
    expect(invoice_repo.find_all_by_merchant_id(123)).to eq([])
    
  end
  it "can find all by customer_id" do
    expect(invoice_repo.find_all_by_cusotmer_id(pending)).to eq([invoice1, invoice2])
    expect(invoice_repo.find_all_by_cusotmer_id(shipped)).to eq([invoice3])
    
  end
  
end 
