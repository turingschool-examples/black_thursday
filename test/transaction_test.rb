require_relative '../lib/transaction'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class TransactionTest < Minitest::Test
  attr_reader :repo

  def test_that_class_exist
    assert Transaction
  end

  def setup
    repo = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => "2016-01-11 10:37:09 UTC",
      :updated_at => "2016-01-11 10:37:09 UTC"
    })
  end

end
