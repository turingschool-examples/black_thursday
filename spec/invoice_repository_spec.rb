require_relative '../lib/invoice_repository'

RSpec.describe InvoiceRepository do
  it 'exists' do
    ivr = InvoiceRepository.new

    expect(ivr).to be_a(InvoiceRepository)
  end  

  it 'starts with no invoices' do
    ivr = InvoiceRepository.new

    expect(ivr.data).to eq([])
  end
end
