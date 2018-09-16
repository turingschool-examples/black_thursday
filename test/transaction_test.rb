require_relative 'test_helper'
require_relative '../lib/transaction.rb'

class TransactionTest <  Minitest::Test
  def test_it_exists
    t = Transaction.new({:id => 6, :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0202",
      :result => "success", :created_at => Time.now,
      :updated_at => Time.now})
    assert_instance_of Transaction, t
  end

  def test_ids
    t = Transaction.new({:id => 6, :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0202",
      :result => "success", :created_at => Time.now,
      :updated_at => Time.now})
    assert_equal 6, t.id
    assert_equal 8, t.invoice_id
  end

  def test_credit_card_info
    t = Transaction.new({:id => 6, :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0202",
      :result => "success", :created_at => Time.now,
      :updated_at => Time.now})
    assert_equal "4242424242424242", t.credit_card_number
    assert_equal "0202", t.credit_card_expiration_date
    assert_equal "success", t.result
  end

  def test_times
    t = Transaction.new({:id => 6, :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0202",
      :result => "success", :created_at => Time.now,
      :updated_at => Time.now})
    assert_equal Time, t.created_at.class
    assert_equal Time, t.updated_at.class
  end

end
