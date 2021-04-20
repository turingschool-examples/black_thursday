require './data/invoice_item_mocks'

RSpec.describe InvoiceItemMocks do
  describe '#invoice_items_as_mocks' do
    it 'returns mock data of invoice_items' do
      invoice_items_as_mocks = InvoiceItemMocks.invoice_items_as_mocks(self)

      expect(invoice_items_as_mocks).to be_an Array
      invoice_items_as_mocks.each do |invoice_item_mock|
        expect(invoice_item_mock.id).to be_an Integer
        expect(invoice_item_mock.item_id).to be_an Integer
        expect(invoice_item_mock.invoice_id).to be_an Integer
        expect(invoice_item_mock.quantity).to be_an Integer
        expect(invoice_item_mock.unit_price).to be_a Float
        expect(invoice_item_mock.created_at).to match InvoiceItemMocks.date_format
        expect(invoice_item_mock.updated_at).to match InvoiceItemMocks.date_format
      end
    end
    it 'accepts custom hashes' do
      invoice_items_as_hashes = InvoiceItemMocks.invoice_items_as_hashes(number_of_hashes: 2)
      invoice_items_as_mocks = InvoiceItemMocks.invoice_items_as_mocks(self,
                                                                       invoice_items_as_hashes)
      expect(invoice_items_as_mocks.length).to eq 2
    end
  end

  describe '#invoice_items_as_hashes' do
    it 'returns mock data of invoice items' do
      invoice_items_as_hashes = InvoiceItemMocks.invoice_items_as_hashes

      expect(invoice_items_as_hashes).to be_an Array
      expect(invoice_items_as_hashes.length).to eq 10
      expect(invoice_items_as_hashes.first).to be_a Hash
    end
    it 'returns data with expected attributes' do
      invoice_items_as_hashes = InvoiceItemMocks.invoice_items_as_hashes

      invoice_items_as_hashes.each do |invoice_item_hash|
        expect(invoice_item_hash[:id]).to be_an Integer
        expect(invoice_item_hash[:item_id]).to be_an Integer
        expect(invoice_item_hash[:invoice_id]).to be_an Integer
        expect(invoice_item_hash[:quantity]).to be_an Integer
        expect(invoice_item_hash[:unit_price]).to be_a Float
        expect(invoice_item_hash[:created_at]).to match InvoiceItemMocks.date_format
        expect(invoice_item_hash[:updated_at]).to match InvoiceItemMocks.date_format
      end
    end

    it 'returns custom number of data' do
      invoice_items_as_hashes = InvoiceItemMocks.invoice_items_as_hashes(number_of_hashes: 2)
      expect(invoice_items_as_hashes.length).to eq 2
    end
    it 'returns non random dates' do
      invoice_items_as_hashes = InvoiceItemMocks.invoice_items_as_hashes(random_dates: false)
      invoice_items_as_hashes.each do |invoice_item_hash|
        expect(invoice_item_hash[:created_at]).to eq '2021-01-01'
      end
    end
    it 'returns custom ids for item_id' do
      invoice_items_as_hashes = InvoiceItemMocks.invoice_items_as_hashes(item_id: 1)
      invoice_items_as_hashes.each do |invoice_item_hash|
        expect(invoice_item_hash[:item_id]).to eq 1
      end
    end
    it 'returns custom ids for invoice_id' do
      invoice_items_as_hashes = InvoiceItemMocks.invoice_items_as_hashes(invoice_id: 1)
      invoice_items_as_hashes.each do |invoice_item_hash|
        expect(invoice_item_hash[:invoice_id]).to eq 1
      end
    end
    it 'returns custom quantities' do
      invoice_items_as_hashes = InvoiceItemMocks.invoice_items_as_hashes(quantity: 3)
      invoice_items_as_hashes.each do |invoice_item_hash|
        expect(invoice_item_hash[:quantity]).to eq 3
      end
    end
    it 'returns custom unit prices' do
      invoice_items_as_hashes = InvoiceItemMocks.invoice_items_as_hashes(unit_price: 12.54)
      invoice_items_as_hashes.each do |invoice_item_hash|
        expect(invoice_item_hash[:unit_price]).to eq 12.54
      end
    end
  end
end
