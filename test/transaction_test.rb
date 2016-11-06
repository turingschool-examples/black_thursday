require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repo'

class TransactionTest < Minitest::Test
  
  attr_reader :data,
              :repo
  def setup
    @data = Transaction.new({ :id => 6,
                              :invoice_id => 8,
                              :credit_card_number => "4242424242424242",
                              :credit_card_expiration_date => "0220",
                              :result => "success",
                              :created_at => Time.now,
                              :updated_at => Time.now})
    @repo = Minitest::Mock.new
  end

  def test_it_exists
    assert Transaction.new(data, repo)
  end

  def test_it_has_a_class
    skip
    t = Transaction.new(data, repo)
    assert_equal Transaction, t.class
  end

  def test_it_has_an_invoice_id
    skip
    t = Transaction.new(data, repo)
    assert_equal 8, t.invoice_id
  end

  def test_it_has_a_credit_card_number
    skip
    t = Transaction.new(data, repo)
    assert_equal "4242424242424242", t.credit_card_number
  end

  def test_it_has_a_credit_card_expiration_date
    skip
    t = Transaction.new(data, repo)
    assert_equal "0220", t.credit_card_expiration_date
  end

  def test_it_has_a_result
    skip
    t = Transaction.new(data, repo)
    assert_equal "success", t.result
  end

  def test_it_displays_when_it_was_created
    skip
    t = Transacl Time.now, t.created_at
  end

  def test_it_displays_when_it_was_updated
    skip
    t = Transaction.new(data, repo)
    assert_equal Time.now, t.updated_at
    endtion.new(data, repo)
    assert_equal
  end
end
