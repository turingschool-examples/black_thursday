require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/invoice_repository'
require './lib/invoice'
require 'bigdecimal'

RSpec.describe InvoiceRepository do
  describe '#initialize' do
    it 'exists' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      expect(ir).to be_instance_of(InvoiceRepository)
    end
    it 'has items' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      expect(ir.invoices.count).to eq(4985)
    end
  end
  describe '#make_invoices' do
    it 'makes_invoices' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      expect(ir.invoices.first).to be_instance_of(Invoice)
    end
  end
  describe '#all' do
    it 'contains all the invoices' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      expect(ir.all.count).to eq(4985)
    end
  end
  describe '#find_by_id' do
    it 'finds invoices by id' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      test_invoice = Invoice.new({
        id: '1234567890',
        customer_id: '456789',
        merchant_id: '234567890',
        status: 'pending',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'
    },
    ir
    )
      ir.invoices << test_invoice
      expect(ir.find_by_id(1234567890)).to eq(test_invoice)
      expect(ir.find_by_id(123456789099999999)).to eq(nil)
    end
  end
  describe '#find_all_by_customer_id' do
    it 'finds invoices by customer id' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      test_invoice1 = Invoice.new({
        id: '1234567890',
        customer_id: '456789',
        merchant_id: '234567890',
        status: 'pending',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'
    },
    ir
    )
    test_invoice2 = Invoice.new({
        id: '1234567890',
        customer_id: '456789',
        merchant_id: '234567890',
        status: 'pending',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'
    },
    ir
    )
      ir.invoices << test_invoice1
      ir.invoices << test_invoice2
      expect(ir.find_all_by_customer_id(456789)).to eq([test_invoice1, test_invoice2])
      expect(ir.find_all_by_customer_id(123456789099999999)).to eq([])
    end
  end
  describe '#find_all_by_merchant_id' do
    it 'finds invoices by merchant id' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      test_invoice1 = Invoice.new({
        id: '1234567890',
        customer_id: '456789',
        merchant_id: '234567890',
        status: 'pending',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'
    },
    ir
    )
    test_invoice2 = Invoice.new({
        id: '1234567890',
        customer_id: '456789',
        merchant_id: '234567890',
        status: 'pending',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'
    },
    ir
    )
      ir.invoices << test_invoice1
      ir.invoices << test_invoice2
      expect(ir.find_all_by_merchant_id(234567890)).to eq([test_invoice1, test_invoice2])
      expect(ir.find_all_by_merchant_id(123456789099999999)).to eq([])
    end
  end
  describe '#find_all_by_status' do
    it 'finds invoices by status' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      expect(ir.find_all_by_status('pending').count).to eq(1473)
      expect(ir.find_all_by_status('hot dog!')).to eq([])
    end
  end
  describe '#create' do
    it 'create a new invoice instance' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      attributes = {
        id: '1234567890',
        customer_id: '456789',
        merchant_id: '234567890',
        status: 'pending',
        created_at: '2016-01-11 11:51:37 UTC',
        updated_at: '1993-09-29 11:56:40 UTC'
      }
      ir.create(attributes)
      expected = ir.find_by_id(4986)
      expect(expected.merchant_id).to eq(234567890)
    end
  end
#   describe '#update' do
#     it 'updates items attributes' do
#       mock_sales_engine = instance_double('SalesEngine')
#       ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
#       attributes = {
#         name:         'Cool Stuff',
#         description:  'supaaa cool',
#         unit_price:   '1357'
#       }
#       test_item = ir.find_by_id(263567292)
#       ir.update(263567292, attributes)
#       expect(test_item.name).to eq('Cool Stuff')
#       expect(test_item.description).to eq('supaaa cool')
#       expect(test_item.unit_price).to eq(BigDecimal(1357))
#       expect(test_item.merchant_id).to eq(12336050)
#       expect(test_item.created_at.year).to eq(2016)
#       expect(test_item.updated_at.year).to eq(2021)
#     end
#   end
#   describe '#delete' do
#     it 'delete a specified item from the items array' do
#       mock_sales_engine = instance_double('SalesEngine')
#       ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
#       ir.delete(263567292)
#       expect(ir.items.count).to eq(1366)
#     end
#   end
end
