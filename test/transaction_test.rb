require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/invoice_repo'
require './lib/invoice'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repo'
require './lib/item'
require './lib/item_repo'
require './lib/transaction'
require './lib/transaction_repo'

class TransactionTest < MiniTest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv"})
    t = Transaction.new({
                        :id => 6,
                        :invoice_id => 8,
                        :credit_card_number => "4242424242424242",
                        :credit_card_expiration_date => "0220",
                        :result => "success",
                        :created_at => Time.now,
                        :updated_at => Time.now
                        }, self)
    assert_instance_of Transaction, t
  end

  def test_transaction_attributes

    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv"})
    t = Transaction.new({
                        :id => 6,
                        :invoice_id => 8,
                        :credit_card_number => "4242424242424242",
                        :credit_card_expiration_date => "0220",
                        :result => "success",
                        :created_at => Time.now,
                        :updated_at => Time.now
                        }, self)
    expected = t
    assert_equal 6, expected.id
    assert_equal 8, expected.invoice_id
    assert_equal 4242424242424242, expected.credit_card_number
    # assert_equal 0220, expected.credit_card_expiration_date
    assert_equal :success, expected.result
    assert_instance_of Time, expected.created_at
    assert_instance_of Time, expected.updated_at
  end

end
