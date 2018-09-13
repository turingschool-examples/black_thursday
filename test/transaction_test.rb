require 'pry'

require 'minitest/autorun'
require 'minitest/pride'

require './lib/transaction'


class TransactionTet < Minitest::Test

  def setup
    @hash = {
              :id                          => 1,
              :invoice_id                  => "2179",
              :credit_card_number          => "4068631943231473",
              :credit_card_expiration_date => "0217",
              :result                      => "success",
              :created_at                  => "2012-02-26 20:56:56 UTC",
              :updated_at                  => "2012-02-26 20:56:56 UTC"
    }
    @t = Transaction.new(@hash)
  end

  def test_it_exists
    assert_instance_of Transaction, @t
  end

  def test_it_gets_attributes
    assert_equal 1, @t.id
    assert_equal "2179", @t.invoice_id
    assert_equal "4068631943231473", @t.credit_card_number
    assert_equal "0217", @t.credit_card_expiration_date
    assert_equal "success", @t.result
    assert_equal "2012-02-26 20:56:56 UTC", @t.created_at
    assert_equal "2012-02-26 20:56:56 UTC", @t.updated_at
  end


end