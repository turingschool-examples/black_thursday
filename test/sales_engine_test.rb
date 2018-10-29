require './test/test_helper'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({items:"./data/item_test.csv",
                                merchants:"./data/merchant_test.csv", 
                                invoices:"./data/invoices.csv",
                                customers:"./data/customers.csv",
                                invoice_items:"./data/invoice_items.csv"})
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_make_merchant_repo_instance
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_it_can_make_item_repo_instance
    assert_instance_of ItemRepository, @se.items
  end

  def test_that_merchant_repo_contains_merchants
    refute_equal 0, @se.merchants.all.size
  end

  def test_that_item_repo_contains_items
    refute_equal 1, @se.items.all
  end

  def test_that_customer_repo_contains_customers
    refute_equal 0, @se.customers.all
  end
end
