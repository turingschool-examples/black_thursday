require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/Transaction'

class TransactionTest < Minitest::Test

  def setup
    @t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_experation_date => "0218",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })

  end

  def test_it_exists
    assert_instance_of Transaction, @t
  end

  def test_it_has_attributes
    assert_equal 6, @t.id
    assert_equal 8, @t.invoice_id
    assert_equal "4242424242424242", @t.credit_card_number
    assert_equal "0218", @t.credit_card_experation_date
    assert_equal "success", @t.result
    assert_instance_of Time, @t.created_at
    assert_instance_of Time, @t.updated_at
  end
end
