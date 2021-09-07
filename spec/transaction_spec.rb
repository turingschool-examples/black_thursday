require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/transaction_repository'
require './lib/transaction'

RSpec.describe Transaction do
  describe '#initialize' do
    it 'exists' do
      mock_transaction_repo = instance_double('TransactionRepository')
      transaction = Transaction.new({
                                      id: '263395617 ',
                                      invoice_id: '456789',
                                      credit_card_number: '4297222479999999',
                                      credit_card_expiration_date: '2016-01-11 11:51:37 UTC',
                                      result: 'success',
                                      created_at: '2016-01-11 11:51:37 UTC',
                                      updated_at: '1993-09-29 11:56:40 UTC'
                                    },
                                    mock_transaction_repo
                                   )

      expect(transaction).to be_instance_of(Transaction)
    end

    it 'has attributes' do
        mock_transaction_repo = instance_double('TransactionRepository')
        transaction = Transaction.new({
                                        id: '263395617 ',
                                        invoice_id: '456789',
                                        credit_card_number: '4297222479999999',
                                        credit_card_expiration_date: '0420',
                                        result: 'success',
                                        created_at: '2016-01-11 11:51:37 UTC',
                                        updated_at: '1993-09-29 11:56:40 UTC'
                                      },
                                      mock_transaction_repo
                                     )

      expect(transaction.id).to eq(263395617)
      expect(transaction.invoice_id).to eq(456789)
      expect(transaction.credit_card_number).to eq('4297222479999999')
      expect(transaction.credit_card_expiration_date).to eq('0420')
      expect(transaction.result).to eq(:success)
      expect(transaction.created_at.year).to eq(2016)
      expect(transaction.created_at).to be_instance_of(Time)
      expect(transaction.updated_at.year).to eq(1993)
      expect(transaction.updated_at).to be_instance_of(Time)
    end
  end

  describe '#update' do
    it 'updates transactions attributes' do
      mock_transaction_repo = instance_double('TransactionRepository')
      test_transaction = Transaction.new({
                                      id: '263395617 ',
                                      invoice_id: '456789',
                                      credit_card_number: '4297222479999999',
                                      credit_card_expiration_date: '0420',
                                      result: 'success',
                                      created_at: '2016-01-11 11:51:37 UTC',
                                      updated_at: '1993-09-29 11:56:40 UTC'
                                    },
                                    mock_transaction_repo
                                   )

      attributes = {
                      id: '263317',
                      invoice_id: '45678sdfsdf9',
                      credit_card_number: '429999',
                      credit_card_expiration_date: '0520',
                      result: 'hot_dog',
                      created_at: '2016-01-11 11:51:37 UTC',
                      updated_at: '1993-09-29 11:56:40 UTC'
                    }

      test_transaction.update(attributes)

      expect(test_transaction.id).to eq(263395617)
      expect(test_transaction.invoice_id).to eq(456789)
      expect(test_transaction.credit_card_number).to eq('429999')
      expect(test_transaction.credit_card_expiration_date).to eq('0520')
      expect(test_transaction.result).to eq(:hot_dog)
      expect(test_transaction.created_at.year).to eq(2016)
      expect(test_transaction.updated_at.year).to eq(2021)
    end
  end

  describe '#update_credit_card_number' do
    it 'updates credit card numbers' do
      mock_transaction_repo = instance_double('TransactionRepository')
      test_transaction1 = Transaction.new({
                                      id: '263395617 ',
                                      invoice_id: '456789',
                                      credit_card_number: '4297222479999999',
                                      credit_card_expiration_date: '2016-01-11 11:51:37 UTC',
                                      result: 'success',
                                      created_at: '2016-01-11 11:51:37 UTC',
                                      updated_at: '1993-09-29 11:56:40 UTC'
                                    },
                                    mock_transaction_repo
                                   )

      test_transaction2 = Transaction.new({
                                             id: '263395617 ',
                                             invoice_id: '456789',
                                             credit_card_number: '4297222479999999',
                                             credit_card_expiration_date: '2016-01-11 11:51:37 UTC',
                                             result: 'success',
                                             created_at: '2016-01-11 11:51:37 UTC',
                                             updated_at: '1993-09-29 11:56:40 UTC'
                                          },
                                          mock_transaction_repo
                                         )

      attributes1 = {
                      id: '263317',
                      invoice_id: '45678sdfsdf9',
                      credit_card_number: '429999',
                      credit_card_expiration_date: '2021-01-11 11:51:37 UTC',
                      result: 'hot dog',
                      created_at: '2016-01-11 11:51:37 UTC',
                      updated_at: '1993-09-29 11:56:40 UTC'
                    }
      attributes2 = {
                      id: '263317',
                      invoice_id: '45678sdfsdf9',
                      result: 'hot dog',
                      created_at: '2016-01-11 11:51:37 UTC',
                      updated_at: '1993-09-29 11:56:40 UTC'
                    }

      test_transaction1.update_credit_card_number(attributes1)
      test_transaction2.update_credit_card_number(attributes2)

      expect(test_transaction1.credit_card_number).to eq ('429999')
      expect(test_transaction2.credit_card_number).to eq ('4297222479999999')
    end
  end

  describe '#update_credit_card_expiration_date' do
    it 'updates credit card expiration dates' do
      mock_transaction_repo = instance_double('TransactionRepository')
      test_transaction1 = Transaction.new({
                                            id: '263395617 ',
                                            invoice_id: '456789',
                                            credit_card_number: '4297222479999999',
                                            credit_card_expiration_date: '0420',
                                            result: 'success',
                                            created_at: '2016-01-11 11:51:37 UTC',
                                            updated_at: '1993-09-29 11:56:40 UTC'
                                            },
                                            mock_transaction_repo
                                         )

      test_transaction2 = Transaction.new({
                                             id: '26339587617 ',
                                             invoice_id: '456789',
                                             credit_card_number: '4297222479999999',
                                             credit_card_expiration_date: '0420',
                                             result: 'success',
                                             created_at: '2016-01-11 11:51:37 UTC',
                                             updated_at: '1993-09-29 11:56:40 UTC'
                                          },
                                          mock_transaction_repo
                                         )

      attributes1 = {
                      id: '263317',
                      invoice_id: '45678sdfsdf9',
                      credit_card_number: '429999',
                      credit_card_expiration_date: '0520',
                      result: 'hot dog',
                      created_at: '2016-01-11 11:51:37 UTC',
                      updated_at: '1993-09-29 11:56:40 UTC'
                    }
      attributes2 = {
                      id: '263317',
                      invoice_id: '45678sdfsdf9',
                      result: 'hot dog',
                      created_at: '2016-01-11 11:51:37 UTC',
                      updated_at: '1993-09-29 11:56:40 UTC'
                    }

      test_transaction1.update_credit_card_expiration_date(attributes1)
      test_transaction2.update_credit_card_expiration_date(attributes2)

      expect(test_transaction1.credit_card_expiration_date).to eq('0520')
      expect(test_transaction2.credit_card_expiration_date).to eq('0420')
    end
  end

  describe '#update_result' do
    it 'updates credit card result' do
      mock_transaction_repo = instance_double('TransactionRepository')
      test_transaction1 = Transaction.new({
                                            id: '263395617 ',
                                            invoice_id: '456789',
                                            credit_card_number: '4297222479999999',
                                            credit_card_expiration_date: '2016-01-11 11:51:37 UTC',
                                            result: 'success',
                                            created_at: '2016-01-11 11:51:37 UTC',
                                            updated_at: '1993-09-29 11:56:40 UTC'
                                            },
                                            mock_transaction_repo
                                         )

      test_transaction2 = Transaction.new({
                                             id: '26339583457617 ',
                                             invoice_id: '456789',
                                             credit_card_number: '4297222479999999',
                                             credit_card_expiration_date: '2016-01-11 11:51:37 UTC',
                                             result: 'success',
                                             created_at: '2016-01-11 11:51:37 UTC',
                                             updated_at: '1993-09-29 11:56:40 UTC'
                                          },
                                          mock_transaction_repo
                                         )

      attributes1 = {
                      id: '263317',
                      invoice_id: '45678sdfsdf9',
                      credit_card_number: '429999',
                      credit_card_expiration_date: '2021-01-11 11:51:37 UTC',
                      result: 'hot_dog',
                      created_at: '2016-01-11 11:51:37 UTC',
                      updated_at: '1993-09-29 11:56:40 UTC'
                    }
      attributes2 = {
                      id: '263317',
                      invoice_id: '45678sdfsdf9',
                      created_at: '2016-01-11 11:51:37 UTC',
                      updated_at: '1993-09-29 11:56:40 UTC'
                    }

      test_transaction1.update_result(attributes1)
      test_transaction2.update_result(attributes2)

      expect(test_transaction1.result).to eq (:hot_dog)
      expect(test_transaction2.result).to eq (:success)
    end
  end
  describe '#update_time_stamp' do
    it 'updates the updated_at timestamp' do
      mock_transaction_repo = instance_double('TransactionRepository')
      transaction = Transaction.new({
                                      id: '263395617 ',
                                      invoice_id: '456789',
                                      credit_card_number: '4297222479999999',
                                      credit_card_expiration_date: '2016-01-11 11:51:37 UTC',
                                      result: 'success',
                                      created_at: '2016-01-11 11:51:37 UTC',
                                      updated_at: '1993-09-29 11:56:40 UTC'
                                    },
                                    mock_transaction_repo
                                  )
      transaction.update_time_stamp

      expect(transaction.updated_at.year).to eq(2021)
    end
  end
end
