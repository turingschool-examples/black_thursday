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
    @repo = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => 4242424242424242,
      :credit_card_expiration_date => 0220,
      :result => "success",
      :created_at => "2016-01-11 10:37:09 UTC",
      :updated_at => "2016-01-11 10:37:09 UTC"
    })
  end

  def test_that_all_attributes_work_for_transaction_class
    assert_equal                6, repo.id
    assert_equal                8, repo.invoice_id
    assert_equal 4242424242424242, repo.credit_card_number
    assert_equal             0220, repo.credit_card_expiration_date
    assert_equal        "success", repo.result
    assert_equal Time.parse("2016-01-11 10:37:09 UTC"), repo.created_at
    assert_equal Time.parse("2016-01-11 10:37:09 UTC"), repo.updated_at
  end

end
