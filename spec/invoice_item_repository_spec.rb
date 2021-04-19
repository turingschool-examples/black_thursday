require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/invoice_repository'
require './lib/invoice'
require './lib/item'
require './lib/invoice_item_repository'
require 'bigdecimal'

RSpec.describe InvoiceItemRepository do
  describe '#initialize' do

    it 'exists' do
      mock_sales_engine = instance_double('SalesEngine')
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', mock_sales_engine)

      expect(iir).to be_instance_of(InvoiceItemRepository)
    end

    it 'has invoice items' do
      mock_sales_engine = instance_double('SalesEngine')
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', mock_sales_engine)

      expect(iir.invoice_items.count).to eq(50)
    end

    it 'makes invoice items' do
      mock_sales_engine = instance_double('SalesEngine')
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', mock_sales_engine)

      expect(iir.invoice_items.first).to be_instance_of(InvoiceItem)
    end
  end

  describe '#all' do
    it 'finds all InvoiceItems' do
      mock_sales_engine = instance_double('SalesEngine')
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', mock_sales_engine)

      expect(iir.all.count).to eq(50)
    end
  end

  describe '#best_item_for_merchant' do
    it 'finds best items for merchant in terms of revenue generated' do
      se = SalesEngine.from_csv({
          items: './data/items.csv',
          merchants: './data/merchants.csv',
          invoices: './data/invoices.csv',
          customers: './data/customers.csv',
          invoice_items: './data/invoice_items.csv',
          transactions: './data/transactions.csv'
                                  })
      iir = InvoiceItemRepository.new('./data/invoice_items.csv', se)

      expect(iir.best_item_for_merchant(12335311)).to be_a(Item)
      expect(iir.best_item_for_merchant(12335311).id).to eq(263431293)
    end
  end

  describe '#create' do
    it 'creates a new invoice item instance' do
      mock_sales_engine = instance_double('SalesEngine')
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', mock_sales_engine)
      attributes = {
                     id: '951753',
                     item_id: '123654',
                     invoice_id: '654123',
                     quantity: '999',
                     unit_price: '1300',
                     created_at: '2012-03-27 14:54:09 UTC',
                     updated_at: '2013-03-27 14:54:09 UTC'
                    }
      iir.create(attributes)
      expected = iir.find_by_id(51)

      expect(expected.invoice_id).to eq(654123)
    end
  end

  describe '#delete' do
    it 'deletes an invoice item by id' do
      mock_sales_engine = instance_double('SalesEngine')
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', mock_sales_engine)
      iir.delete(1)

      expect(iir.invoice_items.count).to eq(49)
    end
  end

  describe '#find_all_by_item_id' do
    it 'finds all InvoiceItems by id' do
      mock_sales_engine = instance_double('SalesEngine')
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', mock_sales_engine)

      expect(iir.find_all_by_item_id(263539664).count).to eq(1)
      expect(iir.find_all_by_item_id(987654321)).to eq([])
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'finds all InvoiceItems by id' do
      mock_sales_engine = instance_double('SalesEngine')
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', mock_sales_engine)

      expect(iir.find_all_by_invoice_id(1).count).to eq(8)
      expect(iir.find_all_by_invoice_id(987654321)).to eq([])
    end
  end

  describe '#find_by_id' do
    it 'finds all InvoiceItems by id' do
      mock_sales_engine = instance_double('SalesEngine')
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', mock_sales_engine)

      expect(iir.find_by_id(1)).to be_instance_of(InvoiceItem)
      expect(iir.find_by_id(987654321)).to eq(nil)
    end
  end

  describe '#invoice_total' do
    it 'returns total dollar amount of invoice of corresponding id' do
      mock_sales_engine = instance_double('SalesEngine')
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', mock_sales_engine)

      expect(iir.invoice_total(1)).to eq(21067.77)
    end
  end

  describe '#invoice_total_hash' do
    it 'makes a hash of unique invoices ids and their total value' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: 'data/invoice_items.csv',
        transactions: 'data/transactions.csv'
                              })
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', se)

      expect(iir.invoice_total_hash.keys.count).to eq(7)
    end
  end

  describe '#item_quantity_hash' do
    it 'makes a hash of successful invoice id\'s and quantities' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: 'data/invoice_items.csv',
        transactions: 'data/transactions.csv'
                              })
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', se)

      expect(iir.item_quantity_hash(12334105)).to be_a(Hash)
    end
  end

  describe '#item_revenue_hash' do
    it 'makes a hash of successful invoice id\'s and quantities' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: 'data/invoice_items.csv',
        transactions: 'data/transactions.csv'
                              })
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', se)

      expect(iir.item_revenue_hash(12334105)).to be_a(Hash)
    end
  end

  describe '#most_sold_item_for_merchant' do
    it 'finds most sold items for merchant' do
      se = SalesEngine.from_csv({
          items: './data/items.csv',
          merchants: './data/merchants.csv',
          invoices: './data/invoices.csv',
          customers: './data/customers.csv',
          invoice_items: './data/invoice_items.csv',
          transactions: './data/transactions.csv'
                                  })
      iir = InvoiceItemRepository.new('./data/invoice_items.csv', se)

      expect(iir.most_sold_item_for_merchant(12335311)[0]).to be_a(Item)
      expect(iir.most_sold_item_for_merchant(12335311)[0].id).to eq(263557908)
      expect(iir.most_sold_item_for_merchant(12335311).count).to eq(2)
    end
  end

  describe '#update' do
    it 'updates invoice item attributes' do
      mock_sales_engine = instance_double('SalesEngine')
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', mock_sales_engine)
      attributes = {
                     id: '1',
                     item_id: '263519844',
                     invoice_id: '1',
                     quantity: '6',
                     unit_price: '13000',
                     created_at: '2012-03-27 14:54:09 UTC',
                     updated_at: Time.now
                    }
      iir.update(1, attributes)
      expected = iir.find_by_id(1)

      expect(expected.invoice_id).to eq(1)
      expect(expected.quantity).to eq(6)
      expect(expected.unit_price).to eq(13000)
      expect(expected.updated_at.year).to eq(2021)
    end
  end
end
