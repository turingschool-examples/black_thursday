require './test/test_helper'

class TransactionTest < Minitest::Test
  attr_reader :transaction

  def setup
    @transaction = Transaction.new({
      :id                          => 6,
      :invoice_id                  => 8,
      :credit_card_number          => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result                      => "success",
      :created_at                  => "2012-03-27 14:54:09 UTC",
      :updated_at                  => "2012-03-27 14:54:09 UTC"},
      parent = ""
    )
  end

  def test_it_has_an_id
    assert_equal 6, transaction.id
  end

  def test_it_has_an_invoice_id
    assert_equal 8, transaction.invoice_id
  end

  def test_it_has_a_cc_number
    assert_equal "4242424242424242", transaction.credit_card_number
  end

  def test_it_has_a_cc_number
    assert_equal "0220", transaction.credit_card_expiration_date
  end

  def test_it_creates_at_time
    assert_instance_of Time, transaction.created_at
  end

  def test_it_updates_at_time
    assert_instance_of Time, transaction.updated_at
  end

end
