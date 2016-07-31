require_relative './test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  def test_initializing_with_a_hash
    transaction = Transaction.new({:id => 100})

    assert_equal 100, transaction.id
  end

  def test_it_has_all_the_things
    transaction = Transaction.new({
      :id => 400,
      :invoice_id => 257,
      :credit_card_number => 4068631943231473,
      :credit_card_expiration_date => 0417,
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now})

      assert_equal 400, transaction.id
      assert_equal 257, transaction.invoice_id
      assert_equal 4068631943231473, transaction.credit_card_number
      assert_equal 0417, transaction.credit_card_expiration_date
      assert_equal "success", transaction.result
      assert_respond_to transaction, :created_at
      assert_respond_to transaction, :updated_at
  end

  def test_it_accepts_partial_data
    transaction = Transaction.new({:id => 1, :invoice_id => 240})
    assert_equal 1, transaction.id
    assert_equal 240, transaction.invoice_id
    assert_equal nil, transaction.result 
  end

end
