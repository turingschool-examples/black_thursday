require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'

class SalesEngineTest < Minitest::Test
  def set_up
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv", :items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv"})
    SalesEngine.from_csv(files)
  end

  def test_it_exists
    assert_instance_of SalesEngine, set_up
  end

  def test_from_csv_item
    assert_instance_of ItemRepository, set_up.items
  end

  def test_from_csv_merchants
    assert_instance_of MerchantRepository, set_up.merchants
  end

  def test_it_has_merchant_items
    assert_equal 1, set_up.find_merchant_items(12334105).count
  end

  def test_find_merchant_invoice
    assert_equal 1, set_up.find_merchant_invoice(12334115).count
  end

  def test_find_invoice_for_merchant
    assert_instance_of Merchant , set_up.find_invoice_for_merchant(12334115)
  end
end
