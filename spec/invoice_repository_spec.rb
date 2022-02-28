require "./lib/invoice_repository"
require "./lib/invoice"
require "rspec"

RSpec.describe InvoiceRepository do
   
  it "exists" do
    invoice_repo = InvoiceRepository.new([])
    expect(invoice_repo).to be_a(InvoiceRepository)
  end
  
  it "can find all by status" do
    invoice1 = double("invoice", :id =>4,:customer_id =>1,:merchant_id =>12334269,:status => "pending", :created_at =>"2013-08-05",:updated_at =>"2014-06-06")
    invoice2 = double("invoice", :id =>5,:customer_id =>2,:merchant_id =>12334269,:status => "pending", :created_at =>"2014-02-08",:updated_at =>"2014-07-22")
    invoice3 = double("invoice", :id =>12,:customer_id =>1,:merchant_id =>12336617,:status => "shipped", :created_at =>"2014-05-06",:updated_at =>"2014-10-06")
    invoice_repo = InvoiceRepository.new([invoice1, invoice2, invoice3])
    expect(invoice_repo.find_all_by_status("pending")).to eq([invoice1,invoice2])
    expect(invoice_repo.find_all_by_status("shipped")).to eq([invoice3])
  end
  
  it "can find all by merchant_id" do
    invoice1 = double("invoice", :id =>4,:customer_id =>1,:merchant_id =>12334269,:status => "pending", :created_at =>"2013-08-05",:updated_at =>"2014-06-06")
    invoice2 = double("invoice", :id =>5,:customer_id =>2,:merchant_id =>12334269,:status => "pending", :created_at =>"2014-02-08",:updated_at =>"2014-07-22")
    invoice3 = double("invoice", :id =>12,:customer_id =>1,:merchant_id =>12336617,:status => "shipped", :created_at =>"2014-05-06",:updated_at =>"2014-10-06")
    invoice_repo = InvoiceRepository.new([invoice1, invoice2, invoice3])
    expect(invoice_repo.find_all_by_merchant_id(12334269)).to eq([invoice1, invoice2])
    expect(invoice_repo.find_all_by_merchant_id(123)).to eq([])
  end
  
  it "can find all by customer_id" do
    invoice1 = double("invoice", :id =>4,:customer_id =>1,:merchant_id =>12334269,:status => "pending", :created_at =>"2013-08-05",:updated_at =>"2014-06-06")
    invoice2 = double("invoice", :id =>5,:customer_id =>2,:merchant_id =>12334269,:status => "pending", :created_at =>"2014-02-08",:updated_at =>"2014-07-22")
    invoice3 = double("invoice", :id =>12,:customer_id =>1,:merchant_id =>12336617,:status => "shipped", :created_at =>"2014-05-06",:updated_at =>"2014-10-06")
    invoice_repo = InvoiceRepository.new([invoice1, invoice2, invoice3])
    expect(invoice_repo.find_all_by_customer_id(1)).to eq([invoice1, invoice3])
    expect(invoice_repo.find_all_by_customer_id(2)).to eq([invoice2])
    expect(invoice_repo.find_all_by_customer_id(65)).to eq([])
  end
  
end 
