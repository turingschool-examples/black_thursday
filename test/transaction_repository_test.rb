require 'simplecov'
SimpleCov.start

require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @sample_data = './test/fixtures/sample_transactions.csv'
  end

  def test_it_exists
    test = TransactionRepository.new(@sample_data, 'engine')

    assert_instance_of TransactionRepository, test
  end

  def test_it_can_create_repository
    test = TransactionRepository.new(@sample_data, 'engine')

    assert_equal 10, test.create_repository(@sample_data).count
  end

  def test_it_can_inspect
    test = TransactionRepository.new(@sample_data, 'engine')

    assert_equal "#<TransactionRepository 10 rows>", test.inspect
  end

  def test_it_can_give_all
    test = TransactionRepository.new(@sample_data, 'engine')

    assert_equal 10, test.all.count
  end

  def test_it_can_find_by_id
    test = TransactionRepository.new(@sample_data, 'engine')

    assert_equal [test.transactions[0]], test.find_all_by_invoice_id(1)
    assert_nil test.find_by_id(11)
  end

  def test_it_can_find_a_credit_card_number
    test = TransactionRepository.new(@sample_data, 'engine')

    assert_equal [test.transactions[0]], test.find_all_by_credit_card_number(1000000000000001)
    assert_equal [], test.find_all_by_credit_card_number(4444444444444444)
  end

  def test_it_can_find_all_by_result
    test = TransactionRepository.new(@sample_data, 'engine')

    assert_equal [test.transactions[4], test.transactions[8]], test.find_all_by_result("failed")
    assert_equal [], test.find_all_by_result("received")
  end

  def test_it_can_find_max_transaction_id
    test = TransactionRepository.new(@sample_data, 'engine')

    assert_equal 10, test.max_transaction_id
  end

  def test_it_can_create
    test = TransactionRepository.new(@sample_data, 'engine')
    attributes = {
                  :id => 11,
                  :invoice_id => 11,
                  :credit_card_number     => '1000000000000011',
                  :credit_card_expiration_date => '0011',
                  :result => 'pending',
                  :created_at  => Time.now,
                  :updated_at  => Time.now,
                  }

    test.create(attributes)

    assert_equal test.transactions.last, test.find_by_id(11)
    assert_equal 11, test.all.count
  end

  def test_it_can_update
    test = TransactionRepository.new(@sample_data, 'engine')
    original_time = test.find_by_id(1).updated_at
    attributes = {
                  :credit_card_number => '4000400040004001',
                  :credit_card_expiration_date => '0404',
                  :result => 'shipped'
                  }

    test.update(1, attributes)

    assert_equal '4000400040004001', test.find_by_id(1).credit_card_number
    assert_equal '0404', test.find_by_id(1).credit_card_expiration_date
    assert_equal 'shipped', test.find_by_id(1).result
    assert original_time < test.find_by_id(1).updated_at
    assert_nil test.update(25, attributes)
  end

  def test_it_can_delete
    test = TransactionRepository.new(@sample_data, 'engine')

    test.delete(1)

    assert_nil test.find_by_id(1)
  end
end
