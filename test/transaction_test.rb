require_relative 'test_helper'
require_relative '../lib/transaction'
require 'time'

class TrasactionTest < Minitest::Test
  def setup
    @data = {
      id: 6,
      invoice_id: 8,
      credit_card_number: '4242424242424242',
      credit_card_expiration_date: '0220',
      result: 'success',
      created_at: '2012-02-26 20:56:56 UTC',
      updated_at: '2012-02-26 20:56:56 UTC'
    }
    @transaction = Transaction.new(@data, 'TransactionRepo pointer')
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end
end
