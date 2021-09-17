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

  it '#all' do

    expect(@invoice_repo.all).to be_an(Array)
  end

  it "#find_by_id" do
    expect(@invoice_repo.find_by_id(1).merchant_id).to eq(12335938)
  end

  it "#find_all_by_customer_id" do
    expect(@invoice_repo.find_all_by_customer_id(-1)).to eq []
    expect(@invoice_repo.find_all_by_customer_id(1).length).to eq 8
  end

  it "#find_all_by_merchant_id" do
    expect(@invoice_repo.find_all_by_merchant_id(-1)).to eq []
    expect(@invoice_repo.find_all_by_merchant_id(12336642).length).to eq 7
  end

  it "#find_all_by_status" do
    expect(@invoice_repo.find_all_by_status('burned to a crisp')).to eq([])
    expect(@invoice_repo.find_all_by_status('pending').length).to eq(1473)
  end
end
