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
  describe '#find_by_id' do
    it 'finds transactions by id' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      test_transaction = Transaction.new({
                                            id: '263395617',
                                            invoice_id: '456789',
                                            credit_card_number: '4297222479999999',
                                            credit_card_expiration_date: '2016-01-11 11:51:37 UTC',
                                            result: 'success',
                                            created_at: '2016-01-11 11:51:37 UTC',
                                            updated_at: '1993-09-29 11:56:40 UTC'
                                         },
                                         tr
                                        )
      tr.transactions << test_transaction
      expect(tr.find_by_id(263395617)).to eq(test_transaction)
      expect(tr.find_by_id(123456789099999999)).to eq(nil)
    end
  end
  describe '#find_all_by_invoice_id' do
    it 'finds transactions by invoice id' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      test_transaction1 = Transaction.new({
                                             id: '263395617',
                                             invoice_id: '456789',
                                             credit_card_number: '4297222479999999',
                                             credit_card_expiration_date: '2016-01-11 11:51:37 UTC',
                                             result: 'success',
                                             created_at: '2016-01-11 11:51:37 UTC',
                                             updated_at: '1993-09-29 11:56:40 UTC'
                                          },
                                          tr
                                         )
      test_transaction2 = Transaction.new({
                                             id: '263395617999',
                                             invoice_id: '456789',
                                             credit_card_number: '4297222479999999',
                                             credit_card_expiration_date: '2016-01-11 11:51:37 UTC',
                                             result: 'success',
                                             created_at: '2016-01-11 11:51:37 UTC',
                                             updated_at: '1993-09-29 11:56:40 UTC'
                                          },
                                          tr
                                         )
      tr.transactions << test_transaction1
      tr.transactions << test_transaction2
      expect(tr.find_all_by_invoice_id(456789)).to eq([test_transaction1, test_transaction2])
      expect(tr.find_all_by_invoice_id(123456789099999999)).to eq([])
    end
  end
  describe '#find_all_by_credit_card_number' do
    it 'finds transactions by credit card number' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      test_transaction1 = Transaction.new({
                                            id: '263395617',
                                            invoice_id: '456789',
                                            credit_card_number: '4297222479999999',
                                            credit_card_expiration_date: '2016-01-11 11:51:37 UTC',
                                            result: 'success',
                                            created_at: '2016-01-11 11:51:37 UTC',
                                            updated_at: '1993-09-29 11:56:40 UTC'
                                          },
                                          tr
                                         )
      test_transaction2 = Transaction.new({
                                            id: '263395617999',
                                            invoice_id: '456789',
                                            credit_card_number: '4297222479999999',
                                            credit_card_expiration_date: '2016-01-11 11:51:37 UTC',
                                            result: 'success',
                                            created_at: '2016-01-11 11:51:37 UTC',
                                            updated_at: '1993-09-29 11:56:40 UTC'
                                          },
                                          tr
                                         )
    tr.transactions << test_transaction1
    tr.transactions << test_transaction2
    expect(tr.find_all_by_credit_card_number(4297222479999999)).to eq([test_transaction1, test_transaction2])
    expect(tr.find_all_by_credit_card_number(123456789099999999)).to eq([])
    end
  end
  describe '#find_all_by_result' do
    it 'finds transactions by result' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      expect(tr.find_all_by_result('success').count).to eq(40)
      expect(tr.find_all_by_result('hot dog!')).to eq([])
    end
  end
  describe '#generate_new_id' do
    it 'created a new transaction id one higher than current highest' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      expect(tr.generate_new_id).to eq(51)
    end
  end
  describe '#create' do
    it 'create a new transaction instance' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      attributes = {
                     id: '263395617',
                     invoice_id: '456789',
                     credit_card_number: '4297222479999999',
                     credit_card_expiration_date: '2016-01-11 11:51:37 UTC',
                     result: 'success',
                     created_at: '2016-01-11 11:51:37 UTC',
                     updated_at: '1993-09-29 11:56:40 UTC'
                   }
      tr.create(attributes)
      expected = tr.find_by_id(51)
      expect(expected.credit_card_number).to eq(4297222479999999)
    end
  end
  describe '#update' do
    it 'updates transactions attributes' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      attributes = {
                      id: '263395617',
                      invoice_id: '456789',
                      credit_card_number: '4297222479999999',
                      credit_card_expiration_date: '2021-01-11 11:51:37 UTC',
                      result: 'hot dog',
                      created_at: '2016-01-11 11:51:37 UTC',
                      updated_at: '1993-09-29 11:56:40 UTC'
                    }
      test_transaction = tr.find_by_id(1)
      tr.update(1, attributes)
      expect(test_transaction.id).to eq(1)
      expect(test_transaction.invoice_id).to eq(2179)
      expect(test_transaction.credit_card_number).to eq(4297222479999999)
      expect(test_transaction.credit_card_expiration_date.year).to eq(2021)
      expect(test_transaction.result).to eq('hot dog')
      expect(test_transaction.created_at.year).to eq(2012)
      expect(test_transaction.updated_at.year).to eq(2021)
    end
  end
  describe '#delete' do
    it 'delete a specified invoice from the transactions array' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      tr.delete(1)
      expect(tr.transactions.count).to eq(4984)
    end
  end

#   describe '#percentage_by_status' do
#     it 'shows percent of transactions by status' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)

#       expect(tr.percentage_by_status(:pending)).to eq(50.00)
#       expect(tr.percentage_by_status(:shipped)).to eq(33.33)
#       expect(tr.percentage_by_status(:returned)).to eq(16.67)
#     end
#   end

#   describe '#transactions_by_days' do
#     it 'shows count of transactions per day of week' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)

#       expect(tr.transactions_by_days).to eq({ 'Friday' => 701,
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

#       expect(tr.average(tr.transactions_by_days)).to eq(712.1428571428571)
#     end
#   end

#   describe '#hash_variance_from_mean' do
#     it 'shows variance from mean' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)

#       expect(tr.hash_variance_from_mean(tr.transactions_by_days)).to eq({ 'Friday' => 124.16326530612173,
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

#       expect(tr.standard_deviation(tr.transactions_by_days)).to eq(18.07)
#     end
#   end

#   describe '#top_sales_days' do
#     it 'shows standard deviation' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)

#       expect(tr.top_sales_days).to eq(['Wednesday'])
#     end
#   end

#   describe '#transactions_per_merchant' do
#     it 'shows transactions by merchant' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)

#       expect(tr.transactions_per_merchant.keys.count).to eq(475)
#     end
#   end
#   describe '#average_transactions_per_merchant' do
#     it 'shows average number of transactions by merchant' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      
#       expect(tr.average_transactions_per_merchant).to eq(10.49)
#     end
#   end
#   describe '#stdev_transactions_per_merchant' do
#     it 'shows standard deviation of transactions by merchant' do
#       mock_sales_engine = instance_double('SalesEngine')
#       tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)
      
#       expect(tr.stdev_transactions_per_merchant).to eq(3.29)
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
