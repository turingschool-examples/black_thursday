require './test/test_helper'
require './lib/transaction_repository'
require './lib/transaction'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @tr = TransactionRepository.new
    @now = Time.now
    @tr_1 = {
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "3232323232323232",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => @now,
      :updated_at => @now
    }


    @tr_2 = {
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "failure",
      :created_at => @now,
      :updated_at => @now
    }

    @tr_3 = {
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => @now,
      :updated_at => @now
    }
  end

  def create_transactions
    @tr.create(@tr_1)
    @tr.create(@tr_2)
    @tr.create(@tr_3)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tr
  end

  def test_it_has_a_type
    assert_equal Transaction, @tr.type
  end

  def test_it_has_an_attr_whitelist
    expected = [:credit_card_number, :credit_card_expiration_date, :result]

    assert_equal expected, @tr.attr_whitelist
  end

  def test_find_all_by_credit_card_number_returns_empty_array_when_no_matches
    create_transactions

    assert_equal [], @tr.test_find_all_by_credit_card_number("4848484848484848")
  end

  def test_find_all_by_credit_card_number_returns_matching_transactions
    skip
  end

end
