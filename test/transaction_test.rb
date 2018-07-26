require './test/test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test

  def setup
    @transaction = Transaction.new({
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
    assert_instance_of Transaction, @transaction
  end

end
