gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative "../lib/transactions_repository"
require_relative "../lib/sales_engine"
require 'csv'


class TranactionRepositoryTest < MiniTest::Test
  attr_reader :transaction_repository

  def setup
    # @se = SalesEngine.from_csv({
    #                              :items     => "./data/items.csv",
    #                              :merchants => "./data/merchants.csv",
    #                             })
    @transaction_repository = TransactionRepository.new("./data/transactions.csv")
  end

  def test_it_maker_polulates_all_with_instances_of_item
    assert_instance_of Transaction, transaction_repository.all.first
    assert_equal 999, transaction_repository.all.length
  end

  def test_it_finds_by_id
    assert_instance_of Transaction, transaction_repository.find_by_id(1)
    assert_equal 2179, transaction_repository.find_by_id(1).invoice_id
  end

  def test_it_finds_all_by_invoice_id_is_invalid
    assert_equal [], transaction_repository.find_all_by_invoice_id(9999999)
  end

  def test_it_finds_all_by_invoice_id
    assert_instance_of Transaction, transaction_repository.find_all_by_invoice_id(2179).first
    assert_equal 2, transaction_repository.find_all_by_invoice_id(2179).length
    assert_equal 1, transaction_repository.find_all_by_invoice_id(2179).first.id
  end

  def test_it_finds_all_by_credit_card_number_is_invalid
    assert_equal [], transaction_repository.find_all_by_credit_card_number(9999999)
  end

  def test_it_finds_all_by_credit_card_number
    assert_instance_of Transaction, transaction_repository.find_all_by_credit_card_number(4068631943231473).first
    assert_equal 1, transaction_repository.find_all_by_credit_card_number(4068631943231473).length
    assert_equal 2179, transaction_repository.find_all_by_credit_card_number(4068631943231473).first.invoice_id
  end

  def test_it_finds_all_by_result_is_invalid
    assert_equal [], transaction_repository.find_all_by_result(9999999)
  end

  def test_it_finds_all_by_result
    assert_instance_of Transaction, transaction_repository.find_all_by_result('success').first
    assert_equal 830, transaction_repository.find_all_by_result('success').length
    assert_equal 2179, transaction_repository.find_all_by_result('success').first.invoice_id
  end

end
