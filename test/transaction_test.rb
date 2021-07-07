require_relative './test_helper'

class TransactionTest < Minitest::Test
  def test_it_exists
    t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    
    assert_instance_of Transaction, t
  end

  def test_it_has_attributes
    t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => "2016-01-11 12:29:33 UTC",
    :updated_at => "2018-01-11 12:29:33 UTC"
    })

    assert_equal 6,t.id
    assert_equal 8,t.invoice_id
    assert_equal "4242424242424242", t.credit_card_number
    assert_equal "0220", t.credit_card_expiration_date
    assert_equal Time.parse("2016-01-11 12:29:33 UTC"), t.created_at
    assert_equal Time.parse("2018-01-11 12:29:33 UTC"), t.updated_at
  end
end
