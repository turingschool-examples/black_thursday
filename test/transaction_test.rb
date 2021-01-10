require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction'

class TransactionTest < Minitest::Test
  def test_it_exists_and_has_attributes
    t = Transaction.new({
                                  :id => 6,
                                  :invoice_id => 8,
                                  :credit_card_number => '4242424242424242',
                                  :credit_card_expiration_date => '0220',
                                  :result => "success",
                                  :created_at => '2021-01-06 11:29:55 UTC',
                                  :updated_at => '2021-01-06 11:29:55 UTC'
                                  })

    assert_instance_of Transaction, t
    assert_equal 6, t.id
    assert_equal 8, t.invoice_id
    assert_equal '4242424242424242', t.credit_card_number
    assert_equal '0220', t.credit_card_expiration_date
    assert_equal 'success', t.result
    assert_equal Time.parse('2021-01-06 11:29:55 UTC'), t.created_at
    assert_equal Time.parse('2021-01-06 11:29:55 UTC'), t.updated_at
  end
end
