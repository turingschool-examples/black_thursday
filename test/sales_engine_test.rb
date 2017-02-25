require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :se
  def setup
    @se = SalesEngine.from_csv({
      :items => "./test/fixtures/item_fixture.csv",
      :merchants => "./test/fixtures/merchant_fixture.csv",
      :invoices => "./test/fixtures/invoice_fixture.csv"
      })
  end

  def test_child_instances_created
    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_merchant_items
    merchant = se.merchants.find_by_id(12334371)
    assert_equal 2, merchant.items.count
    assert_equal 'Foreign wax cord style', merchant.items.first.name
  end

  def test_item_merchant
    item = se.items.find_by_id(263399187)
    assert_equal '2MAKERSMARKET', item.merchant.name
  end

  def test_find_merchant_invoices
    merchant = se.merchants.find_by_id(12334371)
    assert_equal 11, merchant.invoices.count
    assert_equal 156, merchant.invoices.first.id
  end

  def test_find_invoice_merchant
    invoice = se.invoices.find_by_id(268)
    assert_equal 'Woodenpenshop', invoice.merchant.name
  end

end
