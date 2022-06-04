require_relative './spec_helper'

RSpec.describe InvoiceRepository do
  before :each do
    @invoice_repository = InvoiceRepository.new("./data/invoices.csv")
  end

  it "exists" do
    expect(@invoice_repository).to be_instance_of(InvoiceRepository)
  end

  it 'returns an array of all known Invoice instances' do
    expect(@invoice_repository.all.count).to eq(4985)
  end

  it 'can returns nil or instance of Invoice' do
    expect(@invoice_repository.find_by_id(74587)).to equal(nil)
    expect(@invoice_repository.find_by_id(7)).to be_instance_of(Invoice)
  end

  it 'can return an empty [] or one or more with a matching customer id' do
    expect(@invoice_repository.find_all_by_customer_id(1000)).to eq([])
    expect(@invoice_repository.find_all_by_customer_id(300).length).to eq(10)
  end

  it 'returns either an empty [] or one or more matches with matching merchant id' do
    expect(@invoice_repository.find_all_by_merchant_id(1000)).to eq([])
    expect(@invoice_repository.find_all_by_merchant_id(12335080).length).to eq(7)
  end

  it 'returns an empty [] or one or more matches with having a matching status' do
    expect(@invoice_repository.find_all_by_status(:sold)).to eq([])
    expect(@invoice_repository.find_all_by_status(:shipped).length).to eq(2839)
    expect(@invoice_repository.find_all_by_status(:pending).length).to eq(1473)
  end

  it 'create a new invoice' do
    attributes = {
                  :customer_id => 7,
                  :merchant_id => 8,
                  :status      => "pending",
                  :created_at  => Time.now ,
                  :updated_at  => Time.now
                  }
    @invoice_repository.create(attributes)
    expect(@invoice_repository.find_by_id(4986)).to be_a(Invoice)
    expect(@invoice_repository.find_by_id(4986).merchant_id).to eq(8)
  end

  it 'can update invoice status' do
    attributes = {
                  :customer_id => 7,
                  :merchant_id => 8,
                  :status      => "pending",
                  :created_at  => Time.now ,
                  :updated_at  => Time.now
                  }
    @invoice_repository.create(attributes)
    invoice_updated_at = @invoice_repository.find_by_id(4986).updated_at
    expect(@invoice_repository.find_by_id(4986)).to be_a(Invoice)
    @invoice_repository.update(4986, {status: "success"})
    expect(@invoice_repository.find_by_id(4986).status).to eq(:success)

    expect(@invoice_repository.find_by_id(4986).updated_at).to be > invoice_updated_at
  end

end
