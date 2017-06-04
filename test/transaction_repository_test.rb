require_relative 'test_helper'
require_relative '../lib/transaction_repository'
require 'pry'
class TransactionRepositoryTest < Minitest::Test

  def test_new_instance
    tr = TransactionRepository.new("./test/data/transactions_fixture.csv", self)

    assert_instance_of TransactionRepository, tr
  end

  def test_new_instance_of_transaction
    tr = TransactionRepository.new("./test/data/transactions_fixture.csv", self)

    assert_instance_of Transaction, tr.contents[1]
  end

  def test_return_all
    tr = TransactionRepository.new("./test/data/transactions_fixture.csv", self)
    expected = [ 2179, 46, 750, 4126, 3715, 4966, 1298, 4898,
                 1752, 4702, 3792, 2179 ]
    x = tr.all
    actual = x.map { |i| i.invoice_id }

    assert_equal expected, actual
  end

  def test_return_find_by_id_good_id
    tr = TransactionRepository.new("./test/data/transactions_fixture.csv", self)
    x = tr.find_by_id(6)
    actual = x.id
    assert_equal 6, actual
    assert_instance_of Transaction, x
  end

  def test_return_find_by_id_bad_id
    tr = TransactionRepository.new("./test/data/transactions_fixture.csv", self)

    assert_nil tr.find_by_id(30)
    assert_nil tr.find_by_id(100)
  end

  def test_return_find_all_by_invoice_id_good_id
    tr = TransactionRepository.new("./test/data/transactions_fixture.csv", self)
    expected = [ 2179, 2179 ]
    x = tr.find_all_by_invoice_id(2179)
    actual = x.map { |i| i.invoice_id }

    assert_equal expected, actual
  end

  


end
