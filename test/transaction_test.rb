require_relative 'test_helper'
require_relative '../lib/transaction'
require 'time'

class TransactionTest < Minitest::Test
  def setup
    @data = {
      id: 6,
      invoice_id: 8,
      credit_card_number: '4242424242424242',
      credit_card_expiration_date: '0220',
      result: 'success',
      created_at: '2012-02-26 20:56:56 UTC',
      updated_at: '2012-02-26 20:56:56 UTC'
    }
    @transaction = Transaction.new(@data, 'TransactionRepo pointer')
  end

  def test_it_exists
    assert_instance_of Transaction, @transaction
  end

  def test_it_initializes_with_information
    assert_equal 6, @transaction.id
    assert_equal 8, @transaction.invoice_id
    assert_equal '4242424242424242', @transaction.credit_card_number
    assert_equal '0220', @transaction.credit_card_expiration_date
    assert_equal Time.utc(2012, 02, 26, 20, 56, 56), @transaction.created_at
    assert_equal Time.utc(2012, 02, 26, 20, 56, 56), @transaction.updated_at
    assert_equal 'TransactionRepo pointer', @transaction.parent
  end
  #
  # def test_item_attributes_have_correct_class
  #   assert_instance_of BigDecimal, @item.unit_price
  #   assert_instance_of Time, @item.created_at
  #   assert_instance_of Time, @item.updated_at
  # end
  #
  # def test_unit_price_to_dollars
  #   assert_equal 13.50, @item.unit_price_to_dollars
  # end
  #
  # def test_finding_merchant_associated_with_item
  #   information = { items: './test/fixtures/items_list_truncated.csv',
  #                   merchants: './test/fixtures/merchants_list_truncated.csv',
  #                   invoices: './test/fixtures/invoices_list_truncated.csv' }
  #   sales_engine = SalesEngine.from_csv(information)
  #   item = sales_engine.items.find_by_id(263_395_237)
  #
  #   assert_instance_of Merchant, item.merchant
  #   assert_equal 12_334_141, item.merchant.id
  # end
end
