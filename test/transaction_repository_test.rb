require "minitest/autorun"
require 'minitest/pride'
require 'csv'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @se= SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv",
      :invoices  => "./data/dummy_invoices.csv",
      :invoice_items => "./data/dummy_invoice_items.csv",
      :transactions =>"./data/dummy_transactions.csv",
      :customers => "./data/dummy_customers.csv" })
      @tr = TransactionRepository.new(@se.csv_hash[:transactions])
      @tr.create_transactions
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tr
  end

  def test_all
    assert_equal 10 , @tr.all.count
  end
  def test_you_can_find_by_id
    transaction = @tr.find_by_id(8)
    assert_equal 8, transaction.id
  end
  def test_you_get_nil_if_invalid
    transaction = @tr.find_by_id(56)
    assert_nil transaction
  end

  def test_you_can_find_all_by_invoice_id
   expected =  @tr.find_all_by_invoice_id(4898)
   assert_equal 3, expected.count
  end

  def test_find_by_credit_card_number
    expected= @tr.find_all_by_credit_card_number('4149654190362629')
    assert_equal 2, expected.count
  end

  def test_it_can_find_all_by_result
    expected= @tr.find_all_by_result('failed')
    assert_equal 1, expected.count
  end

  def test_it_can_create_a_new_id
    expected = @tr.create_id
    assert_equal 11 , expected
  end

  def test_it_can_create_attributes
    attributes = {  invoice_id: 7890,
                    credit_card_number: '4613250127567219',
                    credit_card_expiration_date: '0427',
                    result: 'success',
                    created_at: '2018-07-30',
                    updated_at: '2018-07-30'
                  }
    expected = @tr.create(attributes)

    assert_equal 11, expected.id
    assert_equal 7890, expected.invoice_id
    assert_equal '4613250127567219', expected.credit_card_number
    assert_equal '0427', expected.credit_card_expiration_date
    assert_equal :success, expected.result
    assert_instance_of Time, expected.created_at
    assert_instance_of Time, expected.updated_at
  end

  def test_update
    attributes = {
     credit_card_number: '4613250127567219',
     credit_card_expiration_date: '1203',
     result: 'failed'
   }
   @tr.update(10, attributes)
   expected = @tr.find_by_id(10)

   assert_instance_of Time, expected.updated_at
   assert_equal 290, expected.invoice_id
   assert_equal 10, expected.id
   assert_equal '4613250127567219', expected.credit_card_number
   assert_equal '1203', expected.credit_card_expiration_date
   assert_equal :failed, expected.result
  end

  def test_delete
    @tr.delete(5)

    assert_nil @tr.find_by_id(5)
  end

end
