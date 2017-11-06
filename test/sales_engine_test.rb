require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    files = ({:invoices => "./test/fixture/invoice_fixture.csv",
      :items => "./test/fixture/item_fixture.csv",
      :merchants => "./test/fixture/merchant_fixture.csv",
      :invoice_items => "./test/fixture/invoice_item_fixture.csv",
      :transactions => "./test/fixture/transaction_fixture.csv",
      :customers => "./test/fixture/customer_fixture.csv"})
    SalesEngine.from_csv(files)
  end

  def test_it_exists
    assert_instance_of SalesEngine, setup
  end

  def test_item_repo_is_pulled_in
    assert_instance_of ItemRepository, setup.items
  end

  def test_merch_repo_is_pulled_in
    assert_instance_of MerchantRepository, setup.merchants
  end

  def test_find_merchant_items_things
    assert_equal 3, setup.find_merchant_items(12334185).count
  end

  def test_find_item_merchants
    assert_equal 12334115, setup.find_item_merchant(12334115).id
  end

  def test_find_invoices_for_merchants
    assert_equal 1, setup.find_merchant_invoices(12334123).count
  end

  def test_it_can_find_merchant_by_invoice
    assert_equal 12334115, setup.find_invoice_for_merchants(12334115).id
  end

  def test_it_finds_items_for_invoices
    assert_instance_of Item, setup.find_items_for_invoices(6)[0]
    assert_equal 6, setup.find_items_for_invoices(6).count
  end
end
