require_relative './test_helper'
require_relative '../lib/transaction'


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


  def test_it_has_an_id

    t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
      })
    assert_equal 6, t.id
  end

  def test_it_has_an_invoice_id

    t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
      })
    assert_equal 8, t.invoice_id
  end

  def test_it_has_a_credit_card_number

    t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
      })
    assert_equal "4242424242424242", t.credit_card_number
  end

  def test_it_has_a_credit_card_expiration_date

    t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
      })
    assert_equal "0220", t.credit_card_expiration_date
  end

  def test_it_can_return_a_transaction_result

    t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
      })
    assert_equal "success", t.result
  end

end
