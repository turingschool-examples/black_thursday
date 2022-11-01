require './lib/invoice_repository'

RSpec.describe InvoiceRepository do
  it 'exists and has no invoices by default' do
    invr = InvoiceRepository.new

    expect(invr).to be_a(InvoiceRepository)
    expect(invr.invoices).to eq([])
  end
end