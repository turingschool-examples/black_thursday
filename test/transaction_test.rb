require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'

class TransactionTest < MiniTest::Test

  attr_reader :t

  def setup
    @t = Transaction.new({
                          :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => "2012-02-26 20:56:56 UTC",
                          :updated_at => "2012-02-26 20:56:56 UTC"
                        })
  end

  def test_it_returns_id_as_a_number
    assert_equal 6, t.id
  end

  def test_it_returns_an_invoice_as_a_number
    assert_equal 8, t.invoice_id
  end

  def test_it_returns_a_card_number_as_a_string
    assert_equal "4242424242424242", t.credit_card_number
  end

  def test_returns_a_string_expiration_date_as_a_string
    assert_equal "0220", t.credit_card_expiration_date
  end

  def test_it_returns_result
    assert_equal "success", t.result
  end

  def test_it_returns_the_time_it_was_created_at
    assert_equal "2012-02-26 20:56:56 UTC", t.created_at.to_s
  end

  def test_it_returns_the_time_it_was_last_updated
    assert_equal "2012-02-26 20:56:56 UTC", t.updated_at.to_s
  end

  def test_it_returns_a_time_object_for_created_and_updated_at
    assert_equal Time, t.created_at.class
    assert_equal Time, t.updated_at.class
  end


end
