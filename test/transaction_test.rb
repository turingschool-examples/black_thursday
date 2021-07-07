require './test/test_helper.rb'
require './lib/transaction.rb'

class TransactionTest < Minitest::Test
  def setup
    @t = Transaction.new(
      id: 6,
      invoice_id: 8,
      credit_card_number: '4242424242424242',
      credit_card_expiration_date: '0220',
      result: 'success',
      created_at: '2018-05-29 20:06:09 -0600',
      updated_at: '2018-05-29 20:06:09 -0600'
    )
  end

  def test_it_exists
    assert_instance_of Transaction, @t
  end

  def test_it_has_attributes
    assert_equal 6, @t.id
    assert_equal 8, @t.invoice_id
    assert_equal '4242424242424242', @t.credit_card_number
    assert_equal '0220', @t.credit_card_expiration_date
    assert_equal :success, @t.result
    assert_equal Time.parse('2018-05-29 20:06:09 -0600'), @t.created_at
    assert_equal Time.parse('2018-05-29 20:06:09 -0600'), @t.updated_at
  end
end
