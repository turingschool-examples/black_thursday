require './test/test_helper'
require './lib/transaction'

# Tests transaction class
class TransactionTest < Minitest::Test
  def setup
    mock_repo = mock('Transaction repo')
    @attribute_hash = { id: 6,
                        invoice_id: 8,
                        credit_card_number: '4242424242424242',
                        credit_card_expiration_date: '0220',
                        result: 'success',
                        created_at: '2016-01-11 09:34:06 UTC',
                        updated_at: '2016-01-11 09:34:06 UTC' }
    @transaction = Transaction.new(@attribute_hash, mock_repo)
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_attributes
    expected = 424_242_424_242_424_2
    expected2 = Time.parse('2016-01-11 09:34:06 UTC')

    assert_equal 6, @transaction.id
    assert_equal 8, @transaction.invoice_id
    assert_equal expected, @transaction.credit_card_number
    assert_equal '0220', @transaction.credit_card_expiration_date
    assert_equal 'success', @transaction.result
    assert_equal expected2, @transaction.created_at
    assert_equal expected2, @transaction.updated_at
  end

  def test_it_asks_parent_for_invoice
    mock_repo = stub(invoice: stub(name: 'Invoice'))
    transaction = Transaction.new(@attribute_hash, mock_repo)
    assert_instance_of Mocha::Mock, transaction.invoice
  end
end
