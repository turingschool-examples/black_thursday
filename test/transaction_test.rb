require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  def setup
    @transaction_item = Transaction.new({
                :id => 6,
                :invoice_id => 8,
                :credit_card_number => "4242424242424242",
                :credit_card_expiration_date => "0220",
                :result => "success",
                :created_at => Time.now,
                :updated_at => Time.now
              })
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction_item
  end

  def test_it_has_id
    assert_equal 6, @transaction_item.id
  end

end
