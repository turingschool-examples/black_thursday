require 'minitest/autorun'
require 'bigdecimal'
require 'time'
require 'minitest/pride'
require './lib/transaction'

class TransactionTest < Minitest::Test

  def setup
    @time = "2016-01-11 09:34:06 UTC"
    @transaction = Transaction.new({
      :id                           => "6",
      :invoice_id                   => "8",
      :credit_card_number           => "4242424242424242",
      :credit_card_expiration_date  => "0220",
      :result                       => "success",
      :created_at                   => @time,
      :updated_at                   => @time
    })
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_attributes
    assert_equal 6, @transaction.id
    assert_equal 8, @transaction.invoice_id
    assert_equal 4242424242424242, @transaction.credit_card_number
    assert_equal "0220", @transaction.credit_card_expiration_date
    assert_equal "success", @transaction.result
    assert_instance_of Time, @transaction.created_at
    assert_instance_of Time, @transaction.updated_at
  end


end
