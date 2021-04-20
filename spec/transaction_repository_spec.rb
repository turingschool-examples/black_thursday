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

  describe '#inspect' do
    it 'inspects transactions' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)

      expect(tr).to be_a(TransactionRepository)
      expect(tr.transactions.size).to eq(50)
    end
  end

  describe '#make_transactions' do
    it 'makes_transactions' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_transactions = './spec/truncated_data/transactions_truncated.csv'
      ir = TransactionRepository.new(truncated_transactions, mock_sales_engine)

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
                                         tr)
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
                                          tr)
      test_transaction2 = Transaction.new({
                                             id: '263395617999',
                                             invoice_id: '456789',
                                             credit_card_number: '4297222479999999',
                                             credit_card_expiration_date: '2016-01-11 11:51:37 UTC',
                                             result: 'success',
                                             created_at: '2016-01-11 11:51:37 UTC',
                                             updated_at: '1993-09-29 11:56:40 UTC'
                                          },
                                          tr)
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
                                            credit_card_expiration_date: '0220',
                                            result: 'success',
                                            created_at: '2016-01-11 11:51:37 UTC',
                                            updated_at: '1993-09-29 11:56:40 UTC'
                                          },
                                          tr)
      test_transaction2 = Transaction.new({
                                            id: '263395617999',
                                            invoice_id: '456789',
                                            credit_card_number: '4297222479999999',
                                            credit_card_expiration_date: '0220',
                                            result: 'success',
                                            created_at: '2016-01-11 11:51:37 UTC',
                                            updated_at: '1993-09-29 11:56:40 UTC'
                                          },
                                          tr)
      tr.transactions << test_transaction1
      tr.transactions << test_transaction2

      expect(tr.find_all_by_credit_card_number('4297222479999999')).to eq([test_transaction1, test_transaction2])
      expect(tr.find_all_by_credit_card_number('123456789099999999')).to eq([])
    end
  end

  describe '#find_all_by_result' do
    it 'finds transactions by result' do
      mock_sales_engine = instance_double('SalesEngine')
      tr = TransactionRepository.new('./spec/truncated_data/transactions_truncated.csv', mock_sales_engine)

      expect(tr.find_all_by_result(:success).count).to eq(40)
      expect(tr.find_all_by_result('hot dog!')).to eq([])
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

      expect(expected.credit_card_number).to eq('4297222479999999')
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
                      credit_card_expiration_date: '0220',
                      result: 'hot_dog',
                      created_at: '2016-01-11 11:51:37 UTC',
                      updated_at: '1993-09-29 11:56:40 UTC'
                   }
      test_transaction = tr.find_by_id(1)
      tr.update(1, attributes)

      expect(test_transaction.id).to eq(1)
      expect(test_transaction.invoice_id).to eq(2179)
      expect(test_transaction.credit_card_number).to eq('4297222479999999')
      expect(test_transaction.credit_card_expiration_date).to eq('0220')
      expect(test_transaction.result).to eq(:hot_dog)
      expect(test_transaction.created_at.year).to eq(2012)
      expect(test_transaction.updated_at.year).to eq(2021)

      test_transaction = tr.find_by_id(333333333)
      tr.update(333333333, attributes)

      expect(test_transaction).to eq(nil)
    end
  end

  describe '#delete' do
    it 'delete a specified transaction from the transactions array' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_transactions = './spec/truncated_data/transactions_truncated.csv'
      tr = TransactionRepository.new(truncated_transactions, mock_sales_engine)
      tr.delete(1)

      expect(tr.transactions.count).to eq(49)
      expect(tr.find_by_id(1)).to eq(nil)
    end
  end

  describe '#invoice_paid_in_full?' do
    it 'returns true if invoice with the corresponding id is paid in full' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_transactions = './spec/truncated_data/transactions_truncated.csv'
      tr = TransactionRepository.new(truncated_transactions, mock_sales_engine)

      expect(tr.invoice_paid_in_full?(1)).to eq(true)
      expect(tr.invoice_paid_in_full?(1485)).to eq(false)
      expect(tr.invoice_paid_in_full?(3242342342)).to eq(false)
    end
  end
end
