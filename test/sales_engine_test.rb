require_relative 'test_helper'

require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      items: './test/data/test_items.csv',
      merchants: './test/data/test_merchants.csv',
      invoices: './test/data/test_invoices.csv'
    })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_holds_an_item_repository
    assert_instance_of ItemRepository, @se.items
  end

  def test_it_parses_items_correctly
    assert_equal 34, @se.items.all.length
  end

  def test_it_parses_invoices_correctly
    assert_equal 73, @se.invoices.all.length
  end

  def test_it_parses_merchants_correctly
    assert_equal 7, @se.merchants.all.length
  end

  def test_it_holds_a_merchant_repository
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_it_holds_an_invoice_repository
    assert_instance_of InvoiceRepository, @se.invoices
  end
end
