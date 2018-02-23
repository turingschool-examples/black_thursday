# frozen_string_literal: true

require_relative 'test_helper'

require_relative '../lib/transaction.rb'
require_relative 'mocks/test_engine'

class TransactionTest < Minitest::Test
  TIME = Time.parse '2016-01-11 17:42:32 UTC'
  def setup
    @transaction = Transaction.new(
      { id: 6,
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: '2016-01-11 17:42:32 UTC',
        updated_at: '2016-01-11 17:42:32 UTC' },
      MOCK_TRANSACTION_REPOSITORY
    )
  end

  def test_creates_transaction
    assert_instance_of Transaction, @transaction
  end
end
