require 'rspec'
require './data/invoice_mocks'

RSpec.describe InvoiceMocks do
  describe '#invoices_as_mocks' do
    it 'returns mock data of invoices' do
      invoices_as_mocks = InvoiceMocks.invoices_as_mocks(self)

      expect(invoices_as_mocks).to be_an Array
      invoices_as_mocks.each do |invoice_mock|
        expect(invoice_mock.id).to be_an Integer
        expect(invoice_mock.merchant_id).to be_an Integer
        expect(invoice_mock.customer_id).to be_an Integer
        expect(invoice_mock.created_at).to match InvoiceMocks.date_format
        expect(invoice_mock.updated_at).to match InvoiceMocks.date_format
      end
    end
    it 'accepts custom hashes' do
      invoices_as_hashes = InvoiceMocks.invoices_as_hashes(number_of_hashes: 2)
      invoices_as_mocks = InvoiceMocks.invoices_as_mocks(self, invoices_as_hashes)
      expect(invoices_as_mocks.length).to eq 2
    end
  end

  describe '#invoices_as_hashes' do
    it 'returns mock data of invoices' do
      invoices_as_hashes = InvoiceMocks.invoices_as_hashes

      expect(invoices_as_hashes).to be_an Array
      expect(invoices_as_hashes.length).to eq 10
      expect(invoices_as_hashes.first).to be_a Hash
    end

    it 'generates expected attributes' do
      invoices_as_hashes = InvoiceMocks.invoices_as_hashes

      expect(invoices_as_hashes).to be_an Array
      invoices_as_hashes.each do |invoice_hash|
        expect(invoice_hash[:id]).to be_an Integer
        expect(invoice_hash[:customer_id]).to be_an Integer
        expect(invoice_hash[:merchant_id]).to be_an Integer
        expect(invoice_hash[:created_at]).to match InvoiceMocks.date_format
        expect(invoice_hash[:updated_at]).to match InvoiceMocks.date_format
      end
    end

    it 'returns mock custom number of data of invoices' do
      invoices_as_hashes = InvoiceMocks.invoices_as_hashes(number_of_hashes: 2)
      expect(invoices_as_hashes.length).to eq 2
    end

    it 'returns mocks with custom status' do
      invoices_as_hashes = InvoiceMocks.invoices_as_hashes(status: 'pending')

      invoices_as_hashes.each do |invoice_hash|
        expect(invoice_hash[:status]).to eq 'pending'
      end
    end

    it 'returns mocks with non-random ids' do
      invoices_as_hashes = InvoiceMocks.invoices_as_hashes(customer_id: 1,
                                                           merchant_id: 5)

      invoices_as_hashes.each do |invoice_hash|
        expect(invoice_hash[:customer_id]).to eq 1
        expect(invoice_hash[:merchant_id]).to eq 5
      end
    end

    it 'returns non-random dates' do
      invoices_as_hashes = InvoiceMocks.invoices_as_hashes(random_dates: false)
      invoices_as_hashes.each do |invoice_hash|
        expect(invoice_hash[:created_at]).to eq '2021-01-01'
      end
    end
  end

  describe '#get_a_random_status' do
    it 'returns a random status' do
      actual_status = InvoiceMocks.get_a_random_status
      possible_statuses = ['pending', 'shipped', 'returned']
      expect(possible_statuses.include?(actual_status)).to be true
    end
  end
end
