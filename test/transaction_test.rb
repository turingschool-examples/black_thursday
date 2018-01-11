require_relative "test_helper"
require_relative "../lib/transaction"

class TransactionTest < Minitest::Test

  def setup
    @parent = "parent"
    @transaction = Transaction.new({ :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now},
                          @parent)
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_has_id
    assert_equal 6, @transaction.id
  end

  def test_it_has_invoice_id
    assert_equal 8, @transaction.invoice_id
  end

  def test_it_has_credit_card_number
    assert_equal 4242424242424242, @transaction.credit_card_number
  end

  def test_it_has_credit_card_expiration
    assert_equal "0220", @transaction.credit_card_expiration_date
  end

  def test_it_has_result
    assert_equal "success", @transaction.result
  end

  def test_it_has_created_at
    assert_equal Time.parse(Time.now.to_s), @transaction.created_at
  end

  def test_it_has_updated_at
    assert_equal Time.parse(Time.now.to_s), @transaction.updated_at
  end

  def test_it_has_parent
    assert_equal "parent", @transaction.parent
  end

end
