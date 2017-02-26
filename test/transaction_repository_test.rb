require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../test/file_hash_setup'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'


class TransactionRepositoryTest < Minitest::Test

  attr_reader :file_hash, :path, :se, :repo, :transaction_repository

  include FileHashSetup

  def setup
    super
    @path = 'test/fixtures/transaction_sample.csv'
    @repo = Repository.new(se, path, Transaction)
    @transaction_repository = TransactionRepository.new(se, path)
  end

  def test_it_finds_all_transactions
    assert_equal Array, transaction_repository.all.class
    refute_empty transaction_repository.all
  end

  def test_finds_by_id
    assert_equal Transaction, transaction_repository.find_by_id(1).class
  end

  def test_finds_all_by_invoice_id
    assert_equal Array, transaction_repository.find_all_by_invoice_id(2179).class
    refute_empty transaction_repository.find_all_by_invoice_id(2179)
  end

  def test_find_all_by_credit_card_number
    assert_equal Array, transaction_repository.find_all_by_credit_card_number(4068631943231473).class
    refute_empty transaction_repository.find_all_by_credit_card_number(4068631943231473)
  end

  def test_finds_all_by_result
    assert_equal Array, transaction_repository.find_all_by_result("success").class
    refute_empty transaction_repository.find_all_by_result("success")
  end

end
