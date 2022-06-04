require './lib/invoice_repository'



RSpec.describe InvoiceRepository do
  before :each do
    @Invoice_repository = InvoiceRepository.new("./data/invoices.csv")
  end

  it 'exists' do
    expect(@Invoice_repository).to be_a InvoiceRepository
  end





end
