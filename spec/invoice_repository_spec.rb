require './lib/invoice_repository'

RSpec.describe InvoiceRepository do
  it 'exists' do
    invr = InvoiceRepository.new

    expect(invr).to be_a(InvoiceRepository)
  end
end