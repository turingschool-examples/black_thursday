require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  def test_transaction_exists
    transaction = Transaction.new({
      :id => 23, :invoice_id => 2639, :credit_card_number => 4566763237167619,
      :credit_card_expiration_date => "0220", :result => "success",
      :created_at => "2012-02-26 20:56:57 UTC",
      :updated_at => "2012-02-26 20:56:57 UTC"
      }, self)

    assert_instance_of Transaction, transaction
  end

  def test_transaction_has_id
    transaction = Transaction.new({
      :id => 23, :invoice_id => 2639, :credit_card_number => 4566763237167619,
      :credit_card_expiration_date => "0220", :result => "success",
      :created_at => "2012-02-26 20:56:57 UTC",
      :updated_at => "2012-02-26 20:56:57 UTC"
      }, self)
    id = transaction.id

    assert_equal 23, id 
  end

end
