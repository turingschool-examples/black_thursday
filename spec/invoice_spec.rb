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
        mock_invoice_repo
    )
    
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
        mock_invoice_repo
      )
      invoice.update_time_stamp
     
      expect(invoice.updated_at.year).to eq(2021)
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
                                mock_invoice_repo
                           )
      invoice.day_created
    
      expect(invoice.day_created).to eq('Monday')
    end
  end
end
