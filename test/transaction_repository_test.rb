require_relative '../test/test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @hash = {
      :id => "6",
      :invoice_id => "8",
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => "2016-01-11 09:34:06 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
    }
  end

  def test_it_exists
    tr = TransactionRepository.new
    assert_instance_of TransactionRepository, tr
  end

  def test_has_no_items_to_start
    tr = TransactionRepository.new
    assert_equal [], tr.data
  end

  def test_new_transaction_added_to_transaction_array
    tr = TransactionRepository.new
    tr.create(@hash)
    assert_instance_of Transaction, tr.all[0]
  end

  def test_it_can_find_all_by_invoice_id
    tr = TransactionRepository.new
    tr.create(@hash)
    hash2 = {
      :id => "3",
      :invoice_id => "9",
      :credit_card_number => "3737373737373",
      :credit_card_expiration_date => "2222",
      :result => "failed",
      :created_at => "2016-01-11 09:34:06 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
    }
    tr.create(hash2)
    assert_instance_of Transaction, tr.find_all_by_invoice_id(9)[0]
    assert_equal 1, tr.find_all_by_invoice_id(9).count
  end

  def test__find_all_by_invoice_id_will_return_empty_array_for_no_match
    tr = TransactionRepository.new
    tr.create(@hash)
    hash2 = {
      :id => "3",
      :invoice_id => "9",
      :credit_card_number => "3737373737373",
      :credit_card_expiration_date => "2222",
      :result => "failed",
      :created_at => "2016-01-11 09:34:06 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
    }
    tr.create(hash2)
    assert_equal [], tr.find_all_by_invoice_id(99)
  end

  def test_it_can_find_all_by_credit_card_number
    tr = TransactionRepository.new
    tr.create(@hash)
    hash2 = {
      :id => "3",
      :invoice_id => "9",
      :credit_card_number => "3737373737373",
      :credit_card_expiration_date => "2222",
      :result => "failed",
      :created_at => "2016-01-11 09:34:06 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
    }
    tr.create(hash2)
    assert_instance_of Transaction, tr.find_all_by_credit_card_number("3737373737373")[0]
    assert_equal 1, tr.find_all_by_credit_card_number("3737373737373").count
  end

  def test_it_returns_empty_array_with_no_match_for_cc_num
    tr = TransactionRepository.new
    tr.create(@hash)
    hash2 = {
      :id => "3",
      :invoice_id => "9",
      :credit_card_number => "3737373737373",
      :credit_card_expiration_date => "2222",
      :result => "failed",
      :created_at => "2016-01-11 09:34:06 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
    }
    tr.create(hash2)
    assert_equal [], tr.find_all_by_credit_card_number("3737373700373")
  end

  def test_it_can_find_all_by_result
    tr = TransactionRepository.new
    tr.create(@hash)
    hash2 = {
      :id => "3",
      :invoice_id => "9",
      :credit_card_number => "3737373737373",
      :credit_card_expiration_date => "2222",
      :result => "failed",
      :created_at => "2016-01-11 09:34:06 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
    }
    tr.create(hash2)
    assert_instance_of Transaction, tr.find_all_by_result(:failed)[0]
    assert_equal 1, tr.find_all_by_result(:failed).count
  end

  def test_it_returns_empty_array_with_no_match_for_result
    tr = TransactionRepository.new
    tr.create(@hash)
    hash2 = {
      :id => "3",
      :invoice_id => "9",
      :credit_card_number => "3737373737373",
      :credit_card_expiration_date => "2222",
      :result => "failed",
      :created_at => "2016-01-11 09:34:06 UTC",
      :updated_at => "2016-01-11 09:34:06 UTC"
    }
    tr.create(hash2)
    assert_equal [], tr.find_all_by_result(:pending)
  end


end
