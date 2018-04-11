# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'
require './lib/transaction_repository.rb'
require './lib/sales_engine.rb'

# Tests the functionality of the transaction repository.
class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction

  def setup
    se = SalesEngine.from_csv({:transactions => './fixtures/transactions_test.csv',
                               :invoices     => './fixtures/invoices_test.csv'
      })
    @t = se.transactions
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @t
  end

  def test_it_returns_all_transactions
    expected = 10
    actual = @t.all.length

    assert_equal expected, actual
  end

  def test_it_finds_by_id
    expected = "failed"
    actual = @t.find_by_id(9).result

    assert_equal expected, actual
  end

  def test_it_finds_all_by_invoice_id
    expected = 1
    actual = @t.find_all_by_invoice_id(1752).length

    assert_equal expected, actual
  end

  def test_it_finds_all_by_result
    expected = 9
    actual = @t.find_all_by_result("success").length

    assert_equal expected, actual
  end

  def test_it_finds_all_by_credit_card_number
    expected = 1
    actual = @t.find_all_by_credit_card_number(4149654190362629).length

    assert_equal expected, actual
  end

  def test_it_can_update
    expected = "failed"
    @t.update(8, { result: "failed" })
    actual = @t.find_by_id(8).result

    assert_equal expected, actual
  end

  def test_it_can_create
    expected = 11
    @t.create({ "invoice_id" => 1223, "result" => "success"})
    actual = @t.find_by_id(11).id

    assert_equal expected, actual
  end

  def test_it_can_delete
    @t.delete(9)
    actual = @t.find_by_id(9)

    assert_nil actual
  end

  def test_it_can_find_invoice_by_invoice_id
    expected = 1
    actual = @t.find_invoice_by_invoice_id(2).customer_id

    assert_equal expected, actual
  end


end
