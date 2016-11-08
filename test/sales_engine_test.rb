require_relative 'test_helper'
require_relative  '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({:items => './test/assets/test_items.csv', 
                                    :merchants => './test/assets/test_merchants.csv', 
                                    :invoices => "./test/assets/test_invoices.csv", 
                                    :invoice_items => "./test/assets/test_invoice_items.csv",
                                    :transactions => "./test/assets/test_transactions.csv",
                                    :customers => "./test/assets/test_customers.csv"})
  end

  def test_it_loads_merchants_from_small_file
    assert_equal 31, sales_engine.merchants.all.count
  end

  def test_it_loads_merchants_from_small_file_and_are_accessible_by_id
    assert_equal "Shopin1901", sales_engine.merchants.find_by_id(1).name
  end

  def test_it_loads_merchants_from_small_file_and_are_accessible_by_name
    assert_equal 1, sales_engine.merchants.find_by_name("Shopin1901").id
  end

  def test_it_loads_items_from_small_file
    assert_equal 67, sales_engine.items.all.count
  end

  def test_it_loads_items_from_small_file_and_can_access_by_updated_at
    assert_equal 2012, sales_engine.items.all[0].updated_at.year
  end

  def test_it_loads_items_from_small_file_and_can_access_by_price
    assert_equal 33, sales_engine.items.find_all_by_price(13.50)[0].id
  end

  def test_it_loads_items_from_small_file_and_can_access_with_description
    assert_equal 57, sales_engine.items.find_all_with_description("cherry")[0].id
  end

  def test_it_returns_array_of_items_given_id
    result = sales_engine.find_items_by_merchant_id(55)[0].name
    assert_equal "The Red Flannel Collection - Prices Vary on product", result
  end

  def test_it_returns_merchant_instance_given_merchant_id
    result = sales_engine.find_merchant_by_merchant_id(1)
    assert_equal "Shopin1901", result.name
  end

  def test_it_loads_invoices_and_are_accessible_by_merchant_id
    assert_equal 23, sales_engine.invoices.find_all_by_status(:pending).count
  end

  def test_it_invoices_when_passed_merchant_id
    assert_equal 55, sales_engine.find_invoices_by_merchant_id(55)[0].id
  end

  def test_engine_accesses_invoice_items
    assert_equal 99, sales_engine.invoice_items.all.count
  end

  def test_engine_accesses_transaction_repo
    assert_equal 67, sales_engine.transactions.all.count
  end

  def test_engine_accesses_customer_repo
    assert_equal 31, sales_engine.customers.all.count
  end

  def test_invoice_totaling
    invoice = sales_engine.invoices.find_by_id(2)
    assert_equal 875.53, invoice.total.to_f
  end

end