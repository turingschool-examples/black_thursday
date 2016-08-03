require "./test/test_helper"
require "./lib/transaction"

class TransactionTest < Minitest::Test
  def test_it_can_find_the_id
    transaction = Transaction.new({id: "2"})
    assert_equal 2, transaction.id
  end

  def test_it_can_find_the_invoice_id
    transaction = Transaction.new({invoice_id: "2345"})
    assert_equal 2345, transaction.invoice_id
  end

  def test_it_can_find_the_credit_card_number
    transaction = Transaction.new({credit_card_number: "4242424242424242"})
    assert_equal 4242424242424242, transaction.credit_card_number
  end

  def test_it_can_find_card_experation
    transaction = Transaction.new({credit_card_expiration_date: "0220"})
    assert_equal "0220", transaction.credit_card_expiration_date
  end

  def test_it_knows_the_result
    transaction = Transaction.new({result: "success"})
    assert_equal "success", transaction.result
  end

  def test_it_knows_when_it_was_created
    time = Time.strptime("2012-02-26 20:56:56 UTC", "%Y-%m-%d %H:%M:%S %z")
    transaction = Transaction.new({created_at: "2012-02-26 20:56:56 UTC"})
    assert_equal time, transaction.created_at
  end

  def test_it_knows_when_it_was_updated
    time = Time.strptime("2012-02-26 20:56:56 UTC", "%Y-%m-%d %H:%M:%S %z")
    transaction = Transaction.new({updated_at: "2012-02-26 20:56:56 UTC"})
    assert_equal time, transaction.updated_at
  end
end
