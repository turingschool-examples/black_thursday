require './lib/transactions'
require './test/test_helper'

class TransactionTest < Minitest::Test
  attr_reader :transaction

  def setup
    @transaction = Transaction.new({
                  :id => 6,
                  :invoice_id => 8,
                  :credit_card_number => "4242424242424242",
                  :credit_card_expiration_date => "0220",
                  :result => "success",
                  :created_at => "2012-02-26 20:56:56 UTC",
                  :updated_at => "2012-02-26 20:56:56 UTC"
                  })
  end

  def test_that_it_exists
    assert_instance_of Transaction, transaction
  end

  def test_it_has_an_id_value
    assert_equal 6, transaction.id
  end

  def test_it_has_an_invoice_id
    assert_equal 8, transaction.invoice_id
  end

  def test_it_has_a_credit_Card_number_value
    assert_equal 4242424242424242, transaction.credit_card_number
  end

  def test_it_has_an_expiration_date_value
    assert_equal "0220", transaction.credit_card_expiration_date
  end

  def test_it_has_a_result_value
    assert_equal "success", transaction.result
  end

  def test_it_has_a_created_at_value
    assert_instance_of Time , transaction.created_at
  end

  def test_it_has_an_updated_at_value
    assert_instance_of Time , transaction.updated_at
  end

  def test_it_has_a_parent_value
    assert_nil transaction.parent
  end
end
