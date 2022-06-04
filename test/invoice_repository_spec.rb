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
end
