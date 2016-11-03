require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  attr_reader :parent, :transaction, :transaction_dos
  def setup 
    @parent = Minitest::Mock.new
    @transaction = Transaction.new({  :id => '1', 
                                      :invoice_id => '2179',
                                      :credit_card_number => '4068631943231473',
                                      :credit_card_expiration_date => '0217',
                                      :result => 'success',
                                      :created_at => '2012-02-26 20:56:56 UTC',
                                      :updated_at =>  '2012-02-26 20:56:56 UTC'},
                                      parent)
    @transaction_dos = Transaction.new({  :id => '24', 
                                          :invoice_id => '29',
                                          :credit_card_number => '40231473',
                                          :credit_card_expiration_date => '0290',
                                          :result => 'failure',
                                          :created_at => '2015-02-26 20:56:56 UTC',
                                          :updated_at =>  '2010-02-26 20:56:56 UTC'},
                                          parent)                                  
              
  end

  def test_that_transaction_stores_id
    assert_equal 1, transaction.id
    assert_equal 24, transaction_dos.id
  end

  def test_that_transaction_stores_invoice_id
    assert_equal 2179, transaction.invoice_id
    assert_equal 29, transaction_dos.invoice_id
  end

  def test_that_transaction_stores_credit_card_number
    assert_equal 4068631943231473, transaction.credit_card_number
    assert_equal 40231473, transaction_dos.credit_card_number
  end

  def test_that_transaction_stores_credit_card_expiration_date
    assert_equal '0217', transaction.credit_card_expiration_date
    assert_equal '0290', transaction_dos.credit_card_expiration_date
  end

  def test_that_transaction_stores_result
    assert_equal :success, transaction.result 
    assert_equal :failure, transaction_dos.result 
  end

  def test_that_transaction_stores_created_at
    assert_equal Time.parse('2012-02-26 20:56:56 UTC'), transaction.created_at
    assert_equal Time.parse('2015-02-26 20:56:56 UTC'), transaction_dos.created_at
  end

  def test_that_transaction_stores_updated_at
    assert_equal Time.parse('2012-02-26 20:56:56 UTC'), transaction.updated_at
    assert_equal Time.parse('2010-02-26 20:56:56 UTC'), transaction_dos.updated_at
  end

end