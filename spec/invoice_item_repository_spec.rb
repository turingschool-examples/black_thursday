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
  describe '#find_by_id' do
    it 'finds all InvoiceItems by id' do
      mock_sales_engine = instance_double('SalesEngine')
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', mock_sales_engine)
      expect(iir.find_by_id(1)).to be_instance_of(InvoiceItem)
      expect(iir.find_by_id(987654321)).to eq(nil)
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
end


# describe '#find_all_by_customer_id' do
# it 'finds invoices by customer id' do
#   mock_sales_engine = instance_double('SalesEngine')
#   ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
#   test_invoice1 = Invoice.new({
#     id: '1234567890',
#     customer_id: '456789',
#     merchant_id: '234567890',
#     status: 'pending',
#     created_at: '2016-01-11 11:51:37 UTC',
#     updated_at: '1993-09-29 11:56:40 UTC'
# },
# ir
# )
# test_invoice2 = Invoice.new({
#     id: '1234567890',
#     customer_id: '456789',
#     merchant_id: '234567890',
#     status: 'pending',
#     created_at: '2016-01-11 11:51:37 UTC',
#     updated_at: '1993-09-29 11:56:40 UTC'
# },
# ir
# )
#   ir.invoices << test_invoice1
#   ir.invoices << test_invoice2
#   expect(ir.find_all_by_customer_id(456789)).to eq([test_invoice1, test_invoice2])
#   expect(ir.find_all_by_customer_id(123456789099999999)).to eq([])
# end
# end
# describe '#find_all_by_merchant_id' do
# it 'finds invoices by merchant id' do
#   mock_sales_engine = instance_double('SalesEngine')
#   ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
#   test_invoice1 = Invoice.new({
#     id: '1234567890',
#     customer_id: '456789',
#     merchant_id: '234567890',
#     status: 'pending',
#     created_at: '2016-01-11 11:51:37 UTC',
#     updated_at: '1993-09-29 11:56:40 UTC'
# },
# ir
# )
# test_invoice2 = Invoice.new({
#     id: '1234567890',
#     customer_id: '456789',
#     merchant_id: '234567890',
#     status: 'pending',
#     created_at: '2016-01-11 11:51:37 UTC',
#     updated_at: '1993-09-29 11:56:40 UTC'
# },
# ir
# )
#   ir.invoices << test_invoice1
#   ir.invoices << test_invoice2
#   expect(ir.find_all_by_merchant_id(234567890)).to eq([test_invoice1, test_invoice2])
#   expect(ir.find_all_by_merchant_id(123456789099999999)).to eq([])
# end
# end
# describe '#find_all_by_status' do
# it 'finds invoices by status' do
#   mock_sales_engine = instance_double('SalesEngine')
#   ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
#   expect(ir.find_all_by_status('pending').count).to eq(1473)
#   expect(ir.find_all_by_status('hot dog!')).to eq([])
# end
# end
# describe '#create' do
# it 'create a new invoice instance' do
#   mock_sales_engine = instance_double('SalesEngine')
#   ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
#   attributes = {
#     id: '1234567890',
#     customer_id: '456789',
#     merchant_id: '234567890',
#     status: 'pending',
#     created_at: '2016-01-11 11:51:37 UTC',
#     updated_at: '1993-09-29 11:56:40 UTC'
#   }
#   ir.create(attributes)
#   expected = ir.find_by_id(4986)
#   expect(expected.merchant_id).to eq(234567890)
# end
# end
# describe '#update' do
# it 'updates invoices attributes' do
#   mock_sales_engine = instance_double('SalesEngine')
#   ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
#   attributes = {
#     status: :success,
#     id: 5000,
#     customer_id: 2,
#     merchant_id: 3,
#     created_at: Time.now
#     }
#   test_invoice = ir.find_by_id(1)
#   ir.update(1, attributes)
#   expect(test_invoice.id).to eq(1)
#   expect(test_invoice.customer_id).to eq(1)
#   expect(test_invoice.merchant_id).to eq(12335938)
#   expect(test_invoice.status).to eq(:success)
#   expect(test_invoice.created_at.year).to eq(2009)
#   expect(test_invoice.updated_at.year).to eq(2021)
# end
# end
# describe '#delete' do
# it 'delete a specified invoice from the invoices array' do
#   mock_sales_engine = instance_double('SalesEngine')
#   ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
#   ir.delete(1)
#   expect(ir.invoices.count).to eq(4984)
# end
# end
