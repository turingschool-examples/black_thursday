require './lib/invoice_repository'
require './lib/invoice'

RSpec.describe InvoiceRepository do
  before :each do
    @invoice_repository = InvoiceRepository.new('./data/invoices.csv')
    @i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
  end

  it "exists" do
    expect(@invoice_repository).to be_a(InvoiceRepository)
  end

  it "has an array of invoice instance" do
    expect(@invoice_repository.all).to be_a(Array)
    expect(@invoice_repository.all.length).to eq(4985)
    expect(@invoice_repository.all.first).to be_a(Invoice)
    expect(@invoice_repository.all.first.id).to eq(1)
  end

end
