require 'simplecov'
SimpleCov.start
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @transaction_repository = TransactionRepository.new
    @transaction_repository.create_with_id({id: 1,
                                    invoice_id: 1,
                                    credit_card_number: 1234567890,
                                    credit_card_expiration_date: "2012-08-09",
                                    result: "success",
                                    created_at: "2012-08-08",
                                    updated_at: "2018-09-15"
                                    })
    @transaction_repository.create_with_id({id: 2,
                                    invoice_id: 2,
                                    credit_card_number: 2234567890,
                                    credit_card_expiration_date: "2012-01-12",
                                    result: "pending",
                                    created_at: "2012-08-08",
                                    updated_at: "2018-09-15"
                                    })
    @transaction_repository.create_with_id({id: 3,
                                    invoice_id: 3,
                                    credit_card_number: 3234567890,
                                    credit_card_expiration_date: "2012-01-12",
                                    result: "shipped",
                                    created_at: "2012-08-08",
                                    updated_at: "2018-09-15"
                                    })
    @transaction_repository.create_with_id({id: 4,
                                    invoice_id: 3,
                                    credit_card_number: 3234567890,
                                    credit_card_expiration_date: "2012-01-12",
                                    result: "success",
                                    created_at: "2012-08-08",
                                    updated_at: "2018-09-15"
                                    })
    end

    def test_it_exists
      assert_instance_of TransactionRepository, @transaction_repository
    end

    def test_it_starts_with_no_transactions
      tr = TransactionRepository.new
      assert_equal [], tr.all
    end

    def test_we_can_find_by_id
      expected = 1
      result = @transaction_repository.find_by_id(1).id
      assert_equal expected, result
    end

    def test_we_can_find_find_all_by_invoice_id
      tr_1 = @transaction_repository.find_by_id(3)
      tr_2 = @transaction_repository.find_by_id(4)
      expected = [tr_1, tr_2]
      result = @transaction_repository.find_all_by_invoice_id(3)
      assert_equal expected, result
    end

    def test_we_can_find_all_by_credit_card_number
      tr_1 = @transaction_repository.find_by_id(3)
      tr_2 = @transaction_repository.find_by_id(4)
      expected = [tr_1, tr_2]
      result = @transaction_repository.find_all_by_credit_card_number(3234567890)
      assert_equal expected, result
    end

    def test_we_can_find_all_by_result
      tr_1 = @transaction_repository.find_by_id(1)
      tr_2 = @transaction_repository.find_by_id(4)
      expected = [tr_1, tr_2]
      result = @transaction_repository.find_all_by_result(:success)
      assert_equal expected, result
    end

    def test_we_can_update_a_transaction_by_id
      transaction = @transaction_repository.find_by_id(1)
      assert_equal 1234567890, transaction.credit_card_number
      assert_equal :success, transaction.result
      @transaction_repository.update(1, {credit_card_number: 9876543210,
                                         result: :pending})
      assert_equal 9876543210, transaction.credit_card_number
      assert_equal :pending, transaction.result
    end

end
