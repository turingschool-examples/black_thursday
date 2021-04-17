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

  describe '#all' do
    it 'returns all known InvoiceItem instances' do
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(MockData.invoice_items_as_hashes)
      ii_repo = InvoiceItemRepository.new('fake.csv')

      expected = ii_repo.all.length
      expect(expected).to eq 10
    end
  end

  describe '#find_by_id' do
    it 'returns either nil or an instance of InvoiceItemRepository with matching ID' do
      mock_data = MockData.invoice_items_as_mocks(self)
      allow_any_instance_of(InvoiceItemRepository).to receive(:create_invoice_items).and_return(mock_data)
      ii_repo = InvoiceItemRepository.new('fake.csv')

      expected = ii_repo.invoice_items.first
      expect(ii_repo.find_by_id(50)).to eq nil
      expect(ii_repo.find_by_id(0)).to eq expected
    end
  end
end
