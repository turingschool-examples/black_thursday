require './lib/invoice_repository'

RSpec.describe InvoiceRepository do
  it 'exists and has no invoices by default' do
    invr = InvoiceRepository.new

    expect(invr).to be_a(InvoiceRepository)
    expect(invr.invoices).to eq([])
  end

  it 'can find by id' do
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
  end
end