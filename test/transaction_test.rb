
require 'time'
require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test

  def setup
    @t = Transaction.new({"id"          => '1',
                          "invoice_id"  => '11',
                   "credit_card_number" => "4242424242424242",
         "credit_card_expiration_date"  => '0220',
                          "result"      => "success",
                          "created_at"  => '1993-09-29 11:56:40 UTC',
                          "updated_at"  => '1993-09-29 11:56:40 UTC'
                         })

  end

  def test_if_class_creates

    assert_instance_of Transaction, @t
  end

  def test_default_attributes_and_format

    assert_equal 1, @t.id
    assert_equal 11, @t.invoice_id
    assert_equal "4242424242424242", @t.credit_card_number
    assert_equal "0220", @t.credit_card_expiration_date
    assert_equal "success", @t.result
    assert @t.created_at
    assert @t.updated_at
  end

end
