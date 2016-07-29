require "./test/test_helper"
require "./lib/transactions"

class TransactionTest < Minitest::Test

  def setup
    @hash = {:id => "2",
             :invoice_id => "2345",
             :credit_card_number => "4242424242424242",
             :credit_card_expiration_date => "0220",
             :result => "success",
             :created_at => "2012-02-26 20:56:56 UTC",
             :updated_at => "2012-02-26 20:56:56 UTC"}
  end

  def test_it_can_find_the_id
    assert_equal 2, Transactions.new(@hash).id
  end

  def test_it_can_find_the_invoice_id
    assert_equal 2345, Transactions.new(@hash).invoice_id
  end

  def test_it_can_find_the_credit_card_number
    assert_equal "4242424242424242", Transactions.new(@hash).credit_card_number
  end

  def test_it_can_find_card_experation
    assert_equal "0220", Transactions.new(@hash).credit_card_expiration_date
  end

  def test_it_knows_the_result
    assert_equal "success", Transactions.new(@hash).result
  end

  def test_it_knows_when_it_was_created
    time = Time.strptime("2012-02-26 20:56:56 UTC", "%Y-%m-%d %H:%M:%S %z")
    assert_equal time, Transactions.new(@hash).created_at
  end

  def test_it_knows_when_it_was_updated
    time = Time.strptime("2012-02-26 20:56:56 UTC", "%Y-%m-%d %H:%M:%S %z")
    assert_equal time, Transactions.new(@hash).updated_at
  end

end
