require './lib/invoice_repository'

RSpec.describe InvoiceRepository do
  it 'exists and has no invoices by default' do
    invr = InvoiceRepository.new

    expect(invr).to be_a(InvoiceRepository)
    expect(invr.invoices).to eq([])
  end

  it 'can find all' do
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})

    expect(se.invoices.all.first).to be_a Invoice
    expect(se.invoices.all).to be_a Array
  end

  it 'can find by id' do
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})

    expect(se.invoices.find_by_id(1)).to eq(se.invoices.all.first)
  end
end