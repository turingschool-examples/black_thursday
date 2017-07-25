require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction'

class TransactionTest < Minitest::Test

  def test_it_exist
    transaction = Transaction.new({
                                  :id => 6,
                                  :invoice_id => 8,
                                  :credit_card_number => "4242424242424242",
                                  :credit_card_expiration_date => "0220",
                                  :result => "success",
                                  :created_at => Time.now,
                                  :updated_at => Time.now })

    assert_instance_of Transaction, transaction
  end

  def test_it_has_an_id
    transaction = Transaction.new({
                                  :id => 6,
                                  :invoice_id => 8,
                                  :credit_card_number => "4242424242424242",
                                  :credit_card_expiration_date => "0220",
                                  :result => "success",
                                  :created_at => Time.now,
                                  :updated_at => Time.now })

    assert_equal 6, transaction.id
  end

  def test_it_has_an_invoice_id
    transaction = Transaction.new({
                                  :id => 6,
                                  :invoice_id => 8,
                                  :credit_card_number => "4242424242424242",
                                  :credit_card_expiration_date => "0220",
                                  :result => "success",
                                  :created_at => Time.now,
                                  :updated_at => Time.now })

    assert_equal 8, transaction.invoice_id
  end

  def test_it_has_a_CC_number
    transaction = Transaction.new({
                                  :id => 6,
                                  :invoice_id => 8,
                                  :credit_card_number => "4242424242424242",
                                  :credit_card_expiration_date => "0220",
                                  :result => "success",
                                  :created_at => Time.now,
                                  :updated_at => Time.now })

    assert_equal "4242424242424242", transaction.credit_card_number
  end

  def test_CC_number_has_expiration
    transaction = Transaction.new({
                                  :id => 6,
                                  :invoice_id => 8,
                                  :credit_card_number => "4242424242424242",
                                  :credit_card_expiration_date => "0220",
                                  :result => "success",
                                  :created_at => Time.now,
                                  :updated_at => Time.now })

    assert_equal "0220", transaction.credit_card_expiration_date
  end

  def test_has_a_result
    transaction = Transaction.new({
                                  :id => 6,
                                  :invoice_id => 8,
                                  :credit_card_number => "4242424242424242",
                                  :credit_card_expiration_date => "0220",
                                  :result => "success",
                                  :created_at => Time.now,
                                  :updated_at => Time.now })

    assert_equal "success", transaction.result
  end

  def test_it_has_a_created_time
    transaction = Transaction.new({
                                  :id => 6,
                                  :invoice_id => 8,
                                  :credit_card_number => "4242424242424242",
                                  :credit_card_expiration_date => "0220",
                                  :result => "success",
                                  :created_at => Time.now,
                                  :updated_at => Time.now })

    assert_equal Time, transaction.created_at
  end

  def test_it_has_an_updated_time
    transaction = Transaction.new({
                                  :id => 6,
                                  :invoice_id => 8,
                                  :credit_card_number => "4242424242424242",
                                  :credit_card_expiration_date => "0220",
                                  :result => "success",
                                  :created_at => Time.now,
                                  :updated_at => Time.now })

    assert_equal Time, transaction.updated_at
  end

end
