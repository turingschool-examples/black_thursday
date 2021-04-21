require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/invoice_repository'
require './lib/invoice'

RSpec.describe Invoice do
  describe '#initialize' do
    it 'exists' do
      mock_invoice_repo = instance_double('InvoiceRepository')
      invoice = Invoice.new({
            id: '263395617 ',
            customer_id: '456789',
            merchant_id: '234567890',
            status: 'pending',
            created_at: '2016-01-11 11:51:37 UTC',
            updated_at: '1993-09-29 11:56:40 UTC'
        },
        mock_invoice_repo
      )

      expect(invoice).to be_instance_of(Invoice)
    end

    it 'has attributes' do
      mock_invoice_repo = instance_double('InvoiceRepository')
      invoice = Invoice.new({
          id: '263395617',
          customer_id: '456789',
          merchant_id: '234567890',
          status: 'pending',
          created_at: '2016-01-11 11:51:37 UTC',
          updated_at: '1993-09-29 11:56:40 UTC'
        },
          mock_invoice_repo)

      expect(invoice.id).to eq(263395617)
      expect(invoice.customer_id).to eq(456789)
      expect(invoice.merchant_id).to eq(234567890)
      expect(invoice.status).to eq(:pending)
      expect(invoice.created_at.year).to eq(2016)
      expect(invoice.created_at).to be_instance_of(Time)
      expect(invoice.updated_at.year).to eq(1993)
      expect(invoice.updated_at).to be_instance_of(Time)
    end
  end

  describe '#day_created' do
    it 'shows day of week that invoice was created' do
      mock_invoice_repo = instance_double('InvoiceRepository')
      invoice = Invoice.new(  {
                                id: '263395617',
                                customer_id: '456789',
                                merchant_id: '234567890',
                                status: 'pending',
                                created_at: '2016-01-11 11:51:37 UTC',
                                updated_at: '1993-09-29 11:56:40 UTC'
                              },
                                mock_invoice_repo)
      invoice.day_created

      expect(invoice.day_created).to eq('Monday')
    end
  end

  describe '#items' do
    xit 'tells you which items are on the invoice' do
      se = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
      })

      invoice = se.find_invoice_by_id(1)

      expect(invoice.items[0]).to be_a(Item)
    end
  end

  describe '#paid_in_full?' do
    it 'tells you if the invoice was paid in full' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      mock_invoice_repo = instance_double('InvoiceRepository')
      invoice = Invoice.new(  {
                                id: '2197',
                                customer_id: '456789',
                                merchant_id: '234567890',
                                status: 'pending',
                                created_at: '2016-01-11 11:51:37 UTC',
                                updated_at: '1993-09-29 11:56:40 UTC'
                              },
                                mock_invoice_repo)

      allow(mock_invoice_repo).to receive(:invoice_paid_in_full?) { tr.invoice_paid_in_full?(2197) }

      expect(invoice.paid_in_full?)
    end
  end

  describe '#total_value' do
    it 'tells you the total value of an invoice' do
      se = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
      })

        invoice = se.find_invoice_by_id(1)

      expect(invoice.total_value).to eq(21067.77)
    end
  end

  describe '#update_time_stamp' do
    it 'updates the updated_at timestamp' do
      mock_invoice_repo = instance_double('InvoiceRepository')
      invoice = Invoice.new(  {
                                id: '263395617',
                                    customer_id: '456789',
                                    merchant_id: '234567890',
                                    status: 'pending',
                                    created_at: '2016-01-11 11:51:37 UTC',
                                    updated_at: '1993-09-29 11:56:40 UTC'
                                },
                                mock_invoice_repo)
      invoice.update_time_stamp

      expect(invoice.updated_at.year).to eq(2021)
    end
  end
end
