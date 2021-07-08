require_relative "test_helper"
require './lib/transaction_repository'
require './lib/transaction'

class TransactionRepositoryTest < MiniTest::Test
  attr_reader :transaction

  def setup
    @transaction = TransactionRepository.new({:id => 6,
                                              :invoice_id => 8,
                                              :credit_card_number => "4242424242424242",
                                              :credit_card_expiration_date => "0220",
                                              :result => "success",
                                              :created_at => Time.now,
                                              :updated_at => Time.now
                                            })
                                            
  end

  def test_it_exists
    assert_instance_of TransactionRepository, transaction
  end

  def test_repo_populated_with_transaction_objects
    transaction.populate('./test/fixtures/transactions_fixture.csv')

    assert_instance_of Array, transaction.all
    assert_instance_of Transaction, transaction.all.first
  end

  def test_can_find_transaction_by_id
    transaction.populate('./test/fixtures/transactions_fixture.csv')

    assert_instance_of Transaction, transaction.find_by_id(2)
    assert_nil transaction.find_by_id(7)
  end

  def test_can_retrieve_all_transaction_instances
    transaction.populate('./test/fixtures/transactions_fixture.csv')

    assert_equal 5, transaction.all.length
  end

  def test_can_find_transaction_by_invoice_id
    transaction.populate('test/fixtures/transactions_fixture.csv')

    assert_instance_of Array, transaction.find_all_by_invoice_id(2179)
    assert_equal 0, transaction.find_all_by_invoice_id(3456).count
  end

  def test_can_find_all_transactions_by_credit_card_number
    transaction.populate('test/fixtures/transactions_fixture.csv')

    assert_instance_of Array, transaction.find_all_by_credit_card_number(4177816490204479)
    assert_equal 0, transaction.find_all_by_credit_card_number(1234567890).count
  end

  def test_can_find_all_transactions_by_result
    transaction.populate('test/fixtures/transactions_fixture.csv')

    assert_instance_of Array, transaction.find_all_by_result("succuss")
    assert_equal 0, transaction.find_all_by_result("fail").count
  end

end
