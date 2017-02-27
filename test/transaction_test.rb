require 'minitest/autorun'
require 'time'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  attr_reader :repo, :transaction

  def setup
    @transaction = Transaction.new({
      :id => 1,
      :invoice_id => 2179,
      :credit_card_number => 4068631943231473,
      :credit_card_expiration_date => "0217",
      :result => "success",
      :created_at => "2012-02-26",
      :updated_at => "20:56:56"
      }, repo)
  end

  def test_it_finds_an_id
    assert_equal 1, transaction.id
  end

  def test_it_finds_an_invoice_id
    assert_equal 2179, transaction.invoice_id
  end

  def test_it_finds_a_credit_card_number
    assert_equal 4068631943231473, transaction.credit_card_number
  end

  def test_it_finds_the_expiration_date
    assert_equal "0217", transaction.credit_card_expiration_date
  end

  def test_it_finds_a_result
    assert_equal "success", transaction.result
  end

  def test_it_finds_created_at_date
    assert_equal Time, transaction.created_at.class
  end

  def test_it_finds_a_updated_at_time
    assert_equal Time, transaction.updated_at.class
  end

end
