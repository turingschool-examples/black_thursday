require 'rspec'
require './lib/invoice'
require './data/mock_data'
require './lib/invoice_repository'


describe InvoiceRepository do
  describe '#initialize' do
    it 'exists' do
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoice).and_return(MockData.invoices_as_hash)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository).is_a? InvoiceRepository
    end
  end
end
