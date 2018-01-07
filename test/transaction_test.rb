require_relative 'test_helper'
require 'time'
require_relative "../lib/transaction"


class TransactionTest < Minitest::Test

  def setup
    @transaction = Transaction.new({
      :id                 => "1",
      :invoice_id         => "2179",
      :credit_card_number => "4068631943231473",
      :result             => "success",
      :created_at         => "2018-01-02 14:37:20 -0700",
      :updated_at         => "2018-01-02 14:37:25 -0700"
    })
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_an_id
    assert_equal 1, @transaction.id
  end

  def test_it_has_an_invoice_id
    assert_equal "2179", @transaction.invoice_id
  end

  def test_it_has_a_credit_card_number
    assert_equal "4068631943231473", @transaction.credit_card_number
  end

  def test_it_has_a_result
    assert_equal "success", @transaction.result
  end

  def test_it_creates_at_a_time
    assert_equal Time.parse("2018-01-02 14:37:20 -0700"), @transaction.created_at
  end

  def test_it_returns_time_updated_at
    assert_equal Time.parse("2018-01-02 14:37:25 -0700"), @transaction.updated_at
  end

end
