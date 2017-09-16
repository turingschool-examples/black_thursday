require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
            :items => './test/fixtures/items_truncated_3.csv',
            :merchants => './test/fixtures/merchants_truncated_4.csv',
            :invoices => './test/fixtures/invoices_truncated_56.csv'
    })
  end

  def test_from_csv_created_an_instance_of_sales_engine
    assert_instance_of SalesEngine, se
  end

  def test_from_csv_created_different_repositories_assigned_to_appropriate_instance_variables
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
  end

  def test_items_called_on_merchant_returns_array_of_item_objects_associated_with_merchant
    merchant = se.merchants.find_by_id(12334112)
    actual = merchant.items

    assert_instance_of Item, actual[0]
    assert_instance_of Item, actual[1]
    assert_equal 12334112, actual[0].merchant_id
    assert_equal 12334112, actual[1].merchant_id
    refute_equal actual[0], actual[1]
  end

  def test_merchant_called_on_item_returns_merchant_instance
    item = se.items.find_by_id(263395237)
    actual = item.merchant

    assert_instance_of Merchant, actual
    assert_equal item.merchant_id, actual.id
  end

  def test_invoices_called_on_merchant_returns_array_of_invoice_objects_associated_with_merchant
    merchant = se.merchants.find_by_id(12334105)
    actual = merchant.invoices

    assert_instance_of Invoice, actual[0]
    assert_instance_of Invoice, actual[1]
    assert_equal 12334105, actual[0].merchant_id
    assert_equal 12334105, actual[1].merchant_id
    refute_equal actual[0], actual[1]
  end

  def test_merchant_called_on_invoice_returns_merchant_instance
    invoice = se.invoices.find_by_id(1)
    actual = invoice.merchant

    assert_instance_of Merchant, actual
    assert_equal invoice.merchant_id, actual.id
  end

end
