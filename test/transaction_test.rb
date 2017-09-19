require 'bigdecimal'
require 'time'

require './test/test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test

  def new_transaction(data)
    Fixture.new_record(:transactions, data)
  end

  def transaction_115
    Fixture.find_record(:transactions, 115)
  end

  def transaction_115_expected
    {
      id:                           115,
      invoice_id:                   4442,
      credit_card_number:           4191976989764980,
      credit_card_expiration_date:  '1013',
      result:                       'success',
      created_at:                   Time.parse('2012-02-26 20:57:00 UTC'),
      updated_at:                   Time.parse('2012-02-26 20:57:00 UTC')
    }
  end

  def test_initialize_takes_a_hash_of_strings
    assert_instance_of Transaction, new_transaction({
      id:                           '115',
      invoice_id:                   '4442',
      credit_card_number:           '4191976989764980',
      credit_card_expiration_date:  '1013',
      result:                       'success',
      created_at:                   '2012-02-26 20:57:00 UTC',
      updated_at:                   '2012-02-26 20:57:00 UTC'
    })

  end

  def test_it_has_an_Integer_for_an_id
    assert_equal 115, transaction_115.id
  end

  def test_it_has_an_invoice_id
    assert_equal transaction_115_expected[:invoice_id], transaction_115.invoice_id
  end

  def test_it_has_a_credit_card_number
    assert_equal transaction_115_expected[:credit_card_number], transaction_115.credit_card_number
  end

  def test_it_has_a_credit_card_expiration_date
    assert_equal transaction_115_expected[:credit_card_expiration_date], transaction_115.credit_card_expiration_date
  end

  def test_it_has_a_result_of_transaction
    assert_equal transaction_115_expected[:result], transaction_115.result
  end

  def test_it_has_a_created_at_transaction
    assert_equal transaction_115_expected[:created_at], transaction_115.created_at
  end

  def test_it_has_a_updated_at_transaction
    assert_equal transaction_115_expected[:updated_at], transaction_115.updated_at
  end

  def test_invoice_returns_a_single_invoice
    assert_instance_of Invoice, transaction_115.invoice
  end

  def test_invoice_has_id_same_as_invoice_id
    assert_equal transaction_115.invoice_id, transaction_115.invoice.id
  end


end
