require 'rspec'
require './data/invoice_mocks'
require './lib/invoice'
require './lib/invoice_repository'

describe InvoiceRepository do
  describe '#initialize' do
    it 'exists' do
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(InvoiceMocks.invoices_as_hashes)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository).is_a? InvoiceRepository
    end
  end

  describe '#all' do
    it 'has an array of all invoices' do
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(InvoiceMocks.invoices_as_hashes)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository.all).is_a? Array
      expect(invoice_repository.all.length).to eq 10
    end
  end

  describe '#find_by_id' do
    it 'returns nil if no invoice has specified id' do
      mock_data = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository.find_by_id(500)).to eq nil
    end

    it 'finds invoices by id' do
      mock_data = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expected = invoice_repository.invoices.first
      expect(invoice_repository.find_by_id(0)).to eq expected
    end
  end

  describe '#find_all_by_customer_id' do
    it 'returns empty array for no results' do
      invoice_hashes = InvoiceMocks.invoices_as_hashes(customer_id: 1)
      mock_data = InvoiceMocks.invoices_as_mocks(self, invoice_hashes)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository.find_all_by_customer_id(500)).to eq []
    end

    it 'returns invoices by customer id' do
      invoice_hashes = InvoiceMocks.invoices_as_hashes(customer_id: 1)
      mock_data = InvoiceMocks.invoices_as_mocks(self, invoice_hashes)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository.find_all_by_customer_id(1).length).to eq 10
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'returns empty array for no results' do
      invoice_hashes = InvoiceMocks.invoices_as_hashes(merchant_id: 1)
      mock_data = InvoiceMocks.invoices_as_mocks(self, invoice_hashes)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository.find_all_by_merchant_id(500)).to eq []
    end

    it 'returns invoices by merchant id' do
      invoice_hashes = InvoiceMocks.invoices_as_hashes(merchant_id: 1)
      mock_data = InvoiceMocks.invoices_as_mocks(self, invoice_hashes)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository.find_all_by_merchant_id(1).length).to eq 10
    end
  end

  describe '#find_all_by_status' do
    it 'returns empty array for no results' do
      invoice_hashes = InvoiceMocks.invoices_as_hashes(status: 'pending')
      mock_data = InvoiceMocks.invoices_as_mocks(self, invoice_hashes)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository.find_all_by_status('Unknown Status')).to eq []
    end

    it 'returns invoices by status' do
      invoice_hashes = InvoiceMocks.invoices_as_hashes(status: 'pending')
      mock_data = InvoiceMocks.invoices_as_mocks(self, invoice_hashes)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      expect(invoice_repository.find_all_by_status('pending').length).to eq 10
    end
  end

  describe '#create' do
    it 'creates an Invoice class object' do
      mock_data = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      new_invoice = {
        id: nil,
        customer_id: 1,
        merchant_id: 1,
        status: 'pending',
        created_at: Time.now,
        updated_at: Time.now
      }

      invoice_repository.create(new_invoice)
      created_invoice = invoice_repository.invoices.last

      expect(created_invoice).is_a? Invoice
      expect(created_invoice.id).to eq 10
    end
  end

  describe '#update' do
    it 'updates invoice attributes' do
      mock_data = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      new_invoice = {
        id: nil,
        customer_id: 1,
        merchant_id: 1,
        status: 'pending',
        created_at: Time.now,
        updated_at: Time.new(2020, 12, 31)
      }

      invoice_repository.create(new_invoice)

      attributes = {
        status: 'shipped'
      }

      invoice_repository.update(10, attributes)
      expected = invoice_repository.find_by_id(10)

      expect(expected.status).to eq 'shipped'
      expect(expected.updated_at).to be > Time.new(2020, 12, 31)
    end
  end

  describe '#delete' do
    it 'deletes the object at specified id' do
      mock_data = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      new_invoice = {
        id: nil,
        customer_id: 1,
        merchant_id: 1,
        status: 'pending',
        created_at: Time.now,
        updated_at: Time.new(2020, 12, 31)
      }

      invoice_repository.create(new_invoice)

      expect(invoice_repository.invoices.length).to eq 11

      invoice_repository.delete(10)

      expect(invoice_repository.invoices.length).to eq 10
    end

    it 'does not delete anything without a valid id' do
      mock_data = InvoiceMocks.invoices_as_mocks(self)
      allow_any_instance_of(InvoiceRepository).to receive(:create_invoices).and_return(mock_data)
      invoice_repository = InvoiceRepository.new('fake.csv')

      new_invoice = {
        id: nil,
        customer_id: 1,
        merchant_id: 1,
        status: 'pending',
        created_at: Time.now,
        updated_at: Time.new(2020, 12, 31)
      }

      expect(invoice_repository.invoices.length).to eq 10

      invoice_repository.delete(17)

      expect(invoice_repository.invoices.length).to eq 10
    end
  end
end
