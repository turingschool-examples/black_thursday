require_relative './test_helper'
require 'time'
require './lib/transaction'
require './lib/transaction_repository'
require 'mocha/minitest'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @engine = mock
    @tr = TransactionRepository.new("./fixture_data/transactions_sample.csv", @engine)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of TransactionRepository, @tr
  end

  def test_it_can_create_transactions_from_csv
    assert_equal 128, @tr.all.count
  end

  def test_it_finds_by_id
    transaction = @tr.all.first

    assert_equal transaction, @tr.find_by_id(6)
    assert_nil @tr.find_by_id(1)
  end

  def test_find_all_by_invoice_id
    assert_equal 4, @tr.find_all_by_invoice_id(45).count
    assert_equal [], @tr.find_all_by_invoice_id(14105848451)
  end

  def test_find_all_by_credit_card_number
    credit_card_number_1 = "4709998508762802"
    credit_card_number_2 = "2844"

    assert_equal 2, @tr.find_all_by_credit_card_number(credit_card_number_1).count
    assert_equal 1, @tr.find_all_by_credit_card_number(credit_card_number_2).count
    assert_equal [], @tr.find_all_by_credit_card_number("4709998508762711")
  end

  def test_find_all_by_result
    result = :success

    assert_equal 108, @tr.find_all_by_result(result).count
    assert_equal [], @tr.find_all_by_result(:testing)
  end


  def test_new_highest_id
    assert_equal 4945, @tr.new_highest_id
  end

  def test_it_can_create_new_transaction
    expected = @tr.new_highest_id
    attributes =  {
                  :id => 6,
                  :invoice_id => 8,
                  :credit_card_number => "4242424242424242",
                  :credit_card_expiration_date => "0220",
                  :result => "success",
                  :created_at => Time.now
                  }

    @tr.create(attributes)

    assert_equal expected, attributes[:id]
  end

  def test_it_can_update_transaction
    original_time = @tr.find_by_id(14).updated_at
    attributes = {credit_card_number: "4558368405929183",
                  credit_card_expiration_date: "0417",
                  result: "success",
                  id: 9999}

    @tr.update(14, attributes)

    assert_equal "4558368405929183", @tr.find_by_id(14).credit_card_number
    assert_equal "0417", @tr.find_by_id(14).credit_card_expiration_date
    assert_equal :success, @tr.find_by_id(14).result
    assert_equal 14, @tr.find_by_id(14).id
    assert_equal true, @tr.find_by_id(14).updated_at > original_time
  end

  def test_it_can_delete_transction
    @tr.delete(14)

    assert_nil @tr.find_by_id(14)
  end
end
