require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repo'

class TransactionTest < Minitest::Test
  
  attr_reader :data,
              :repo
  def setup
    @data = { :id => 6,
              :invoice_id => 8,
              :credit_card_number => "4242424242424242",
              :credit_card_expiration_date => "0220",
              :result => "success",
              :created_at => "1999-09-09 12:09:09 UTC",
              :updated_at => "2011-03-08 19:19:19 UTC"}
    @repo = Minitest::Mock.new
  end

  def test_it_exists
    assert Transaction.new(data, repo)
  end

  def test_it_has_a_class
    t = Transaction.new(data, repo)
    assert_equal Transaction, t.class
  end

  def test_it_has_an_invoice_id
    t = Transaction.new(data, repo)
    assert_equal 8, t.invoice_id
  end

  def test_it_has_a_credit_card_number
    t = Transaction.new(data, repo)
    assert_equal "4242424242424242", t.credit_card_number
  end

  def test_it_has_a_credit_card_expiration_date
    t = Transaction.new(data, repo)
    assert_equal "0220", t.credit_card_expiration_date
  end

  def test_it_has_a_result
    t = Transaction.new(data, repo)
    assert_equal "success", t.result
  end

  def test_it_displays_when_it_was_created
    t = Transaction.new(data, repo)
    assert_equal "1999-09-09 12:09:09 UTC", t.created_at.to_s
  end

  def test_it_displays_when_it_was_updated
    t = Transaction.new(data, repo)
    assert_equal "2011-03-08 19:19:19 UTC", t.updated_at.to_s
  end
end
