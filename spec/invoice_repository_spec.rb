require 'rspec'
require './lib/invoice_repository'

describe InvoiceRepository do
  describe '#initialize' do
    it 'exists' do
      ir = InvoiceRepository.new('./data/invoices.csv')

      expect(ir).to be_an_instance_of(InvoiceRepository)
    end
  end
end
