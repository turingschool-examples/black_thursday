require_relative 'test_helper'
require_relative '../lib/transaction_repository'

# Test TransactionRepository
class TransactionRepositoryTest < Minitest::Test
  def setup
    @trans = TransactionRepository.new
  end

  def test_it_exists
    @trans = TransactionRepository.new
    assert_instance_of TransactionRepository, @trans
  end

  def test_it_can_create_transactions_from_csv
    @trans.from_csv('./test/fixtures/transactions_fixtures.csv')
    assert_equal 49, @trans.elements.count
    assert_instance_of Transaction, @trans.elements[12]
    assert_equal 419, @trans.elements[12].invoice_id
    assert_instance_of Transaction, @trans.elements[14]
    assert_equal '1020', @trans.elements[14].credit_card_expiration_date
    assert_equal 'success', @trans.elements[23].result

    assert_nil @trans.elements['id']
    assert_nil @trans.elements[999999999]
    assert_nil @trans.elements[0]
    assert_instance_of Time, @trans.elements[34].created_at
    assert_instance_of Time, @trans.elements[9].updated_at
  end

  def test_all_method
    @trans.from_csv('./test/fixtures/transactions_fixtures.csv')
    all_invoices = @trans.all
    assert_equal 49, all_invoices.count
    assert_instance_of Transaction, all_invoices[0]
    assert_instance_of Transaction, all_invoices[20]
    assert_instance_of Transaction, all_invoices[-1]
    assert_instance_of Array, all_invoices
  end

  def test_find_by_id
    @trans.from_csv('./test/fixtures/transactions_fixtures.csv')
    transaction = @trans.find_by_id(30)
    assert_instance_of Transaction, transaction
    assert_equal 1840, transaction.invoice_id

    invoice2 = @trans.find_by_id(37)
    assert_instance_of Transaction, invoice2
    assert_equal 'failed', invoice2.result
    assert_nil @trans.find_by_id(12345678901234567890)
  end

  def test_find_all_by_invoice_id
    @trans.from_csv('./test/fixtures/transactions_fixtures.csv')
    invoices = @trans.find_all_by_invoice_id(3715)
    assert_instance_of Array, invoices
    assert_instance_of Transaction, invoices[0]
    find = @trans.find_by_id(5)
    assert invoices.include?(find)
    assert_equal 1, invoices.count

    invoices2 = @trans.find_all_by_invoice_id(3477)
    assert_instance_of Array, invoices2
    find = @trans.find_by_id(24)
    find2 = @trans.find_by_id(25)
    find3 = @trans.find_by_id(26)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @trans.find_all_by_invoice_id(9999999999)
    assert_equal [], invoices3
  end

  def test_find_all_by_credit_card_number
    @trans.from_csv('./test/fixtures/transactions_fixtures.csv')
    invoices = @trans.find_all_by_credit_card_number('4055813232766404')
    assert_instance_of Array, invoices
    assert_instance_of Transaction, invoices[0]
    find = @trans.find_by_id(18)
    assert invoices.include?(find)
    assert_equal 1, invoices.count

    invoices2 = @trans.find_all_by_credit_card_number('4586019638473066')
    assert_instance_of Array, invoices2
    find = @trans.find_by_id(37)
    find2 = @trans.find_by_id(38)
    find3 = @trans.find_by_id(39)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @trans.find_all_by_credit_card_number(9999999999)
    assert_equal [], invoices3
  end

  def test_find_all_by_result
    @trans.from_csv('./test/fixtures/transactions_fixtures.csv')
    invoices = @trans.find_all_by_result('success')
    assert_instance_of Array, invoices
    assert_instance_of Transaction, invoices[0]
    find = @trans.find_by_id(1)
    assert invoices.include?(find)
    assert_equal 39, invoices.count

    invoices2 = @trans.find_all_by_result('failed')
    assert_instance_of Array, invoices2
    find = @trans.find_by_id(21)
    find2 = @trans.find_by_id(26)
    find3 = @trans.find_by_id(16)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @trans.find_all_by_result(9999999999)
    assert_equal [], invoices3
  end

  def test_it_can_create_a_new_invoice
    assert_equal 0, @trans.all.count
    time = Time.now
    @trans.create(
      invoice_id:                   8,
      credit_card_number:           '1234567890123456',
      credit_card_expiration_date:  '0518',
      result:                       'success',
      created_at:                   time,
      updated_at:                   time
      )
    assert_equal 1, @trans.all.count
    assert_equal time, @trans.find_by_id(1).updated_at

    @trans.create(
      invoice_id:                   10,
      credit_card_number:           '1234567845123456',
      credit_card_expiration_date:  '0318',
      result:                       'failed',
      created_at:                   time,
      updated_at:                   time
      )
    assert_equal 2, @trans.all.count
    assert_equal 10, @trans.find_by_id(2).invoice_id
  end

  def test_it_can_update_an_existing_invoice
    assert_equal 0, @trans.all.count
    time = Time.now - 1
    @trans.create(
      id:                           3,
      invoice_id:                   8,
      credit_card_number:           '1234567890123456',
      credit_card_expiration_date:  '0518',
      result:                       'success',
      created_at:                   time,
      updated_at:                   time
                )
    assert_equal 1, @trans.all.count
    assert_equal 8, @trans.find_by_id(1).invoice_id

    @trans.update(1, {
      id:                           3,
      invoice_id:                   10,
      credit_card_number:           '1234567890123456',
      credit_card_expiration_date:  '0318',
      result:                       'failed',
      created_at:                   time,
      updated_at:                   time
                    })
    assert_equal 1, @trans.all.count
    assert_equal 10, @trans.find_by_id(1).invoice_id
    assert_equal 'failed', @trans.find_by_id(1).result
    assert_equal '1234567890123456', @trans.find_by_id(1).credit_card_number
    assert_equal '0318', @trans.find_by_id(1).credit_card_expiration_date
    assert time < @trans.find_by_id(1).updated_at
  end

  def test_it_can_delete_an_existing_invoice
    assert_equal 0, @trans.all.count
    time = Time.now
    @trans.create(
      id:                           3,
      invoice_id:                   8,
      credit_card_number:           '1234567890123456',
      credit_card_expiration_date:  '0518',
      result:                       'success',
      created_at:                   time,
      updated_at:                   time
                )
    assert_equal 1, @trans.all.count
    assert_equal 8, @trans.find_by_id(1).invoice_id

    @trans.delete(1)
    assert_equal 0, @trans.all.count
  end
end
