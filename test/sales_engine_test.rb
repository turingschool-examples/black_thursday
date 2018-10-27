require_relative './helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require 'csv'
class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv( {
        :items      => './data/items.csv',
        :merchants  => './data/merchants.csv',
        :invoices => "./data/invoices.csv"
                                } )
  end
  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_create_items
    assert_instance_of Item, @se.create_items[2]
  end

  def test_it_can_create_merchants
    assert_instance_of Merchant, @se.create_merchants[2]
  end

  def test_it_can_create_an_item_repository
    assert_instance_of ItemRepository, @se.items
  end

  def test_it_can_create_a_merchant_repository
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_big_decimal_converts_appropriately
    assert_instance_of BigDecimal, @se.big_decimal_converter('200000')
    assert_equal 2000.00, @se.big_decimal_converter('200000')
  end
  def test_it_can_create_invoice_repository
    assert_instance_of InvoiceRepository, @se.invoices
  end
end
