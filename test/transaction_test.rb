require 'time'
require_relative 'test_helper'
require_relative '../lib/elementals/transaction'

# invoice test class
class TransactionTest < Minitest::Test
  def setup
    @time = Time.now
    attributes = { id: 8,
                   invoice_id: 621,
                   credit_card_number: 4271805778010747,
                   credit_card_expiration_date: '0209',
                   result: 'success',
                   created_at: @time,
                   updated_at: @time }
    @transaction = Transaction.new(attributes)
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_an_id
    assert_equal 8, @transaction.id
  end

  def test_it_has_invoice_id
    assert_equal 621, @transaction.invoice_id
  end

  def test_it_has_credit_card_number
    assert_equal 4271805778010747, @transaction.credit_card_number
  end

  def test_it_has_credit_card_expiration_date
    assert_equal '0209', @transaction.credit_card_expiration_date
  end

  def test_it_has_result
    assert_equal :success, @transaction.result
  end

  def test_it_has_created_at
    assert_equal @time, @transaction.created_at
  end

  def test_it_has_updated_at
    assert_equal @time, @transaction.updated_at
  end
end
