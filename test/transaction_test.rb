require_relative "test_helper"
require_relative "../lib/transaction"

class TransactionTest < Minitest::Test

  def test_it_exists
    transaction = Transaction.new

    assert_instance_of Transaction, transaction
  end

  def test_it_has_id
    t = Transaction.new({ :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now
                          })

    assert_equal 6, t.id
  end

  def test_it_has_invoice_id
    t = Transaction.new({ :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now
                          })

    assert_equal 6, t.invoice_id
  end

  def test_it_has_credit_card_number
    t = Transaction.new({ :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now
                          })

    assert_equal 6, t.credit_card_number
  end

  def test_it_has_credit_card_expiration
    t = Transaction.new({ :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now
                          })

    assert_equal 0220, t.credit_card_expiration
  end

  def test_it_has_result
    t = Transaction.new({ :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now
                          })

    assert_equal "success", t.result
  end

  def test_it_has_created_at
    t = Transaction.new({ :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now
                          })

    assert_equal 0220, t.created_at
  end

  def test_it_has_updated_at
    t = Transaction.new({ :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now
                          })

    assert_equal 0220, t.updated_at
  end



end
