require 'bigdecimal'
require 'time'

require './test/test_helper'

require './lib/transaction'

class TransactionTest < Minitest::Test

  def new_transaction(data)
    Fixture.new_record(:Transaction, data)
  end

  def transaction_invoice_id_2179
    Fixture.find_record(:Transaction, 2179)
  end

  def transaction_item_2179_expected
    {
      id:           1,
      invoice_id:   2179,
      credit_card_number:   4068631943231473,
      credit_card_expiration_date:  '0217',
      result:   'success',
      created_at:   Time.parse('2012-02-26 20:56:56 UTC'),
      updated_at:   Time.parse('2012-02-26 20:56:56 UTC')
    }
  end

  def test_initialize_takes_a_hash_of_strings
    assert_instance_of Transaction, new_transaction({
      id:           '1',
      invoice_id:   '2179',
      credit_card_number:   '4068631943231473',
      credit_card_expiration_date:  '0217',
      result:   'success',
      created_at:   '2012-02-26 20:56:56 UTC',
      updated_at:   '2012-02-26 20:56:56 UTC'
      })

  end

  def test_it_has_an_Integer_for_an_id
    assert_equal 1 , transaction_invoice_id_2179.id
  end

  def test_it_has_an_invoice_id
    assert_equal transaction_item_2179_expected[:invoice_id], transaction_invoice_id_2179.invoice_id
  end

  def test_it_has_a_credit_card_number
    assert_equal transaction_item_2179_expected[:credit_card_number], transaction_invoice_id_2179.credit_card_number
  end

  def test_it_has_a_credit_card_expiration_date
    assert_equal transaction_item_2179_expected[:credit_card_expiration_date], transaction_invoice_id_2179.credit_card_number_expiration_date
  end

  def test_it_has_a_result_of_transaction
    assert_equal transaction_item_2179_expected[:result], transaction_invoice_id_2179.result
  end

  def test_it_has_a_created_at_transaction
    assert_equal transaction_item_2179_expected[:created_at], transaction_invoice_id_2179.created_at
  end

  def test_it_has_a_updated_at_transaction
    assert_equal transaction_item_2179_expected[:updated_at], transaction_invoice_id_2179.updated_at
  end

end
