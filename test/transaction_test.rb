require_relative 'test_helper'
require_relative '../lib/transaction.rb'

class TransactionTest <  Minitest::Test
  def test_it_exists
    t = Transaction.new({
      :id     => 6,
      :invoice_id    => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "success",
      :result => "0202",
      :created_at => Time.now,
      :updated_at => Time.now,
      })
  end

  def test_id
    skip
    actual = i.id
    expected = 1
    assert_equal expected, actual
  end

  def test_created_at
    skip
    actual = i.created_at
    expected = Time.new(2018)
    assert_equal expected, actual
  end

  def test_updated_at
    skip
    actual = i.updated_at
    expected = Time.new(2018)
    assert_equal expected, actual
  end

end
