require 'rspec'
require 'csv'
require './lib/file_io'
require './lib/invoice_item_repository'

describe InvoiceItemRepository do 
  describe '#initialize' do
    it 'exists' do
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(MockData.invoice_items_as_hashes)
      ii_repo = InvoiceItemRepository.new('fake.csv')

      expect(ii_repo).is_a? InvoiceItemRepository
    end
  end
end
