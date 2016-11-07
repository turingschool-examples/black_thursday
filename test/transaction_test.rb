require_relative 'test_helper'
require_relative '../lib/transaction'
require 'bigdecimal'
require 'time'

class TransactionTest < Minitest::Test

  def setup
    transaction_info_1 = ({
      :id                          => "6",
      :invoice_id                  => "8",
      :credit_card_number          => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result                      => "success",
      :created_at                  => "2016-11-01 11:38:28 -0600",
      :updated_at                  => "2016-11-01 14:38:28 -0600"
    })
    transaction_info_2 = ({
      :id                          => nil,
      :invoice_id                  => nil,
      :credit_card_number          => nil,
      :credit_card_expiration_date => nil,
      :result                      => nil,
      :created_at                  => "2016-11-01 11:38:28 -0600",
      :updated_at                  => "2016-11-01 14:38:28 -0600"
    })
    parent = Minitest::Mock.new
    @transaction1 = Transaction.new(transaction_info_1, parent)
    @transaction2 = Transaction.new(transaction_info_2, parent)
    @transaction3 = Transaction.new()
    @transaction4 = Transaction.new({})
  end

  def test_it_exists
    assert @transaction1
  end

  def test_invoice_calls_parent
    @transaction1.parent.expect(:find_invoice_by_id, nil, [8])
    @transaction1.invoice
    @transaction1.parent.verify
  end

  def test_it_initializes_transaction_id
    assert_equal 6, @transaction1.id
  end

  def test_it_initializes_transaction_invoice_id
    assert_equal 8, @transaction1.invoice_id
  end

  def test_it_initializes_transaction_credit_card_number
    expected = 4242424242424242
    assert_equal expected, @transaction1.credit_card_number
  end

  def test_it_initializes_transaction_credit_card_expiration_date
    expected = "0220"
    assert_equal expected, @transaction1.credit_card_expiration_date
  end

  def test_it_initializes_transaction_create_time
    expected = Time.parse("2016-11-01 11:38:28 -0600")
    assert_equal expected, @transaction1.created_at
  end

  def test_it_initializes_transaction_update_time
    expected = Time.parse("2016-11-01 14:38:28 -0600")
    assert_equal expected, @transaction1.updated_at
  end

  def test_it_initializes_transaction_result
    assert_equal "success", @transaction1.result
  end

  def test_it_returns_zero_if_there_is_no_id_given
    assert_equal 0, @transaction2.id
  end

  def test_it_returns_zero_if_there_is_no_invoice_id_given
    assert_equal 0, @transaction2.invoice_id
  end

  def test_it_returns_zero_if_there_is_no_credit_card_number_given
    assert_equal 0, @transaction2.credit_card_number
  end

  def test_it_returns_empty_string_if_there_is_no_cc_exp_date_given
    assert_equal "", @transaction2.credit_card_expiration_date
  end

  def test_it_returns_empty_string_if_there_is_no_result_given
    assert_equal "", @transaction2.result
  end

  def test_it_returns_blank_transaction_object_if_no_data_passed
    assert_equal Transaction, @transaction3.class
    assert_nil @transaction3.id
    assert_nil @transaction3.created_at
    assert_nil @transaction3.result
  end

  def test_it_returns_blank_transaction_object_if_empty_hash_passed
    assert_equal Transaction, @transaction4.class
    assert_nil @transaction4.credit_card_number
    assert_nil @transaction4.invoice_id
    assert_nil @transaction4.updated_at
  end

end