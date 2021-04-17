require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/transaction_repository'
require './lib/transaction'
require 'bigdecimal'

RSpec.describe TransactionRepository do
  describe '#initialize' do
    it 'exists' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      expect(tr).to be_instance_of(TransactionRepository)
    end
    it 'has transactions' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      expect(tr.transactions.count).to eq(50)
    end
  end
  describe '#make_transactions' do
    it 'makes_transactions' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      expect(ir.transactions.first).to be_instance_of(Transaction)
    end
  end
  describe '#all' do
    it 'contains all the transactions' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      expect(tr.all.count).to eq(50)
    end
  end
#   describe '#find_by_id' do
#     it 'finds invoices by id' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
#       test_invoice = Invoice.new({
#         id: '1234567890',
#         customer_id: '456789',
#         merchant_id: '234567890',
#         status: 'pending',
#         created_at: '2016-01-11 11:51:37 UTC',
#         updated_at: '1993-09-29 11:56:40 UTC'
#     },
#     tr
#     )
#       tr.invoices << test_invoice
#       expect(tr.find_by_id(1234567890)).to eq(test_invoice)
#       expect(tr.find_by_id(123456789099999999)).to eq(nil)
#     end
#   end
#   describe '#find_all_by_customer_id' do
#     it 'finds invoices by customer id' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
#       test_invoice1 = Invoice.new({
#         id: '1234567890',
#         customer_id: '456789',
#         merchant_id: '234567890',
#         status: 'pending',
#         created_at: '2016-01-11 11:51:37 UTC',
#         updated_at: '1993-09-29 11:56:40 UTC'
#     },
#     tr
#     )
#     test_invoice2 = Invoice.new({
#         id: '1234567890',
#         customer_id: '456789',
#         merchant_id: '234567890',
#         status: 'pending',
#         created_at: '2016-01-11 11:51:37 UTC',
#         updated_at: '1993-09-29 11:56:40 UTC'
#     },
#     tr
#     )
#       tr.invoices << test_invoice1
#       tr.invoices << test_invoice2
#       expect(tr.find_all_by_customer_id(456789)).to eq([test_invoice1, test_invoice2])
#       expect(tr.find_all_by_customer_id(123456789099999999)).to eq([])
#     end
#   end
#   describe '#find_all_by_merchant_id' do
#     it 'finds invoices by merchant id' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
#       test_invoice1 = Invoice.new({
#         id: '1234567890',
#         customer_id: '456789',
#         merchant_id: '234567890',
#         status: 'pending',
#         created_at: '2016-01-11 11:51:37 UTC',
#         updated_at: '1993-09-29 11:56:40 UTC'
#     },
#     tr
#     )
#     test_invoice2 = Invoice.new({
#         id: '1234567890',
#         customer_id: '456789',
#         merchant_id: '234567890',
#         status: 'pending',
#         created_at: '2016-01-11 11:51:37 UTC',
#         updated_at: '1993-09-29 11:56:40 UTC'
#     },
#     tr
#     )
#       tr.invoices << test_invoice1
#       tr.invoices << test_invoice2
#       expect(tr.find_all_by_merchant_id(234567890)).to eq([test_invoice1, test_invoice2])
#       expect(tr.find_all_by_merchant_id(123456789099999999)).to eq([])
#     end
#   end
#   describe '#find_all_by_status' do
#     it 'finds invoices by status' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
#       expect(tr.find_all_by_status('pending').count).to eq(1473)
#       expect(tr.find_all_by_status('hot dog!')).to eq([])
#     end
#   end
#   describe '#create' do
#     it 'create a new invoice instance' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
#       attributes = {
#         id: '1234567890',
#         customer_id: '456789',
#         merchant_id: '234567890',
#         status: 'pending',
#         created_at: '2016-01-11 11:51:37 UTC',
#         updated_at: '1993-09-29 11:56:40 UTC'
#       }
#       tr.create(attributes)
#       expected = tr.find_by_id(4986)
#       expect(expected.merchant_id).to eq(234567890)
#     end
#   end
#   describe '#update' do
#     it 'updates invoices attributes' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
#       attributes = {
#         status: :success,
#         id: 5000,
#         customer_id: 2,
#         merchant_id: 3,
#         created_at: Time.now
#         }
#       test_invoice = tr.find_by_id(1)
#       tr.update(1, attributes)
#       expect(test_invoice.id).to eq(1)
#       expect(test_invoice.customer_id).to eq(1)
#       expect(test_invoice.merchant_id).to eq(12335938)
#       expect(test_invoice.status).to eq(:success)
#       expect(test_invoice.created_at.year).to eq(2009)
#       expect(test_invoice.updated_at.year).to eq(2021)
#     end
#   end
#   describe '#delete' do
#     it 'delete a specified invoice from the invoices array' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
#       tr.delete(1)
#       expect(tr.invoices.count).to eq(4984)
#     end
#   end

#   describe '#percentage_by_status' do
#     it 'shows percent of invoices by status' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/invoices_truncated.csv', mock_sales_engine)

#       expect(tr.percentage_by_status(:pending)).to eq(50.00)
#       expect(tr.percentage_by_status(:shipped)).to eq(33.33)
#       expect(tr.percentage_by_status(:returned)).to eq(16.67)
#     end
#   end

#   describe '#invoices_by_days' do
#     it 'shows count of invoices per day of week' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)

#       expect(tr.invoices_by_days).to eq({ 'Friday' => 701,
#                                           'Monday' => 696,
#                                           'Saturday' => 729,
#                                           'Sunday' => 708,
#                                           'Thursday' => 718,
#                                           'Tuesday' => 692,
#                                           'Wednesday' => 741 })
#     end
#   end

#   describe '#average' do
#     it 'shows average' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)

#       expect(tr.average(tr.invoices_by_days)).to eq(712.1428571428571)
#     end
#   end

#   describe '#hash_variance_from_mean' do
#     it 'shows variance from mean' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)

#       expect(tr.hash_variance_from_mean(tr.invoices_by_days)).to eq({ 'Friday' => 124.16326530612173,
#                                                                       'Monday' => 260.59183673469283,
#                                                                       'Saturday' => 284.16326530612355,
#                                                                       'Sunday' => 17.16326530612218,
#                                                                       'Thursday' => 34.30612244897997,
#                                                                       'Tuesday' => 405.7346938775497,
#                                                                       'Wednesday' => 832.7346938775529 })
#     end
#   end

#   describe '#standard_deviation' do
#     it 'shows standard deviation' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)

#       expect(tr.standard_deviation(tr.invoices_by_days)).to eq(18.07)
#     end
#   end

#   describe '#top_sales_days' do
#     it 'shows standard deviation' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)

#       expect(tr.top_sales_days).to eq(['Wednesday'])
#     end
#   end

#   describe '#invoices_per_merchant' do
#     it 'shows invoices by merchant' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)

#       expect(tr.invoices_per_merchant.keys.count).to eq(475)
#     end
#   end
#   describe '#average_invoices_per_merchant' do
#     it 'shows average number of invoices by merchant' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      
#       expect(tr.average_invoices_per_merchant).to eq(10.49)
#     end
#   end
#   describe '#stdev_invoices_per_merchant' do
#     it 'shows standard deviation of invoices by merchant' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      
#       expect(tr.stdev_invoices_per_merchant).to eq(3.29)
#     end
#   end
#   describe '#top_merchants_by_invoice_count' do
#     it 'tells which merchants are more than two std deviation above the mean' do
#       mock_sales_engine = instance_double('SalesEngine')
#       mock_merchant_repo = instance_double('MerchantRepository')
#       merchant = Merchant.new({
#                                 id: '1',
#                                 name: 'Shopin1901',
#                                 created_at: '2010-12-10',
#                                 updated_at: '2011-12-04'
#                               }, mock_merchant_repo)
#       allow(mock_sales_engine).to receive(:find_merchant_by_id) { merchant }
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      
#       expect(tr.top_merchants_by_invoice_count.count).to eq(12)
#       expect(tr.top_merchants_by_invoice_count.first).to be_a(Merchant)
#     end
#   end

#   describe '#bottom_merchants_by_invoice_count' do
#     it 'tells which merchants are more than two std deviation below the mean' do
#       mock_sales_engine = instance_double('SalesEngine')
#       mock_merchant_repo = instance_double('MerchantRepository')
#       merchant = Merchant.new({
#                                 id: '1',
#                                 name: 'Shopin1901',
#                                 created_at: '2010-12-10',
#                                 updated_at: '2011-12-04'
#                               }, mock_merchant_repo)
#       allow(mock_sales_engine).to receive(:find_merchant_by_id) { merchant }
#       ir = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
     
#       expect(ir.bottom_merchants_by_invoice_count.count).to eq(4)
#       expect(ir.bottom_merchants_by_invoice_count.first).to be_a(Merchant)
#     end
#   end
end
