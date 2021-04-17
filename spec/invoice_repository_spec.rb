require 'rspec'
require './lib/invoice'
require './data/mock_data'
require './lib/invoice_repository'


describe InvoiceRepository do
  describe '#initialize' do
    it 'exists' do
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(MockData.invoices_as_hashes)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository).is_a? InvoiceRepository
    end
  end

  describe '#all' do
    it 'has an array of all invoices' do
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(MockData.invoices_as_hashes)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository.all).is_a? Array
      expect(invoice_repository.all.length).to eq 10
    end
  end

  describe '#find_by_id' do
    it 'returns nil if no invoice has specified id' do
      mock_data = MockData.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository.find_by_id(500)).to eq nil
    end

    it 'finds invoices by id' do
      mock_data = MockData.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expected = invoice_repository.invoices.first
      expect(invoice_repository.find_by_id(0)).to eq expected
    end
  end

  describe '#find_all_by_customer_id' do
    it 'returns empty array for no results' do
      mock_data = MockData.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository.find_all_by_customer_id(500)).to eq []
    end

    it 'returns invoices by customer id' do
      mock_data = MockData.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository.find_all_by_customer_id(2).length).to eq 4
    end
  end
end
