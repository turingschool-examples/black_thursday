require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader   :repository, 
                :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({:invoices => "./fixture/invoices.csv"})
    @repository = sales_engine.invoices
  end

  def test_it_can_create_invoice_repository
    assert repository
  end

  def test_all_returns_instances_of_invoices
    assert_instance_of Array, repository.all
  end

  def test_it_can_return_instance_of_invoice_with_matching_id
    assert repository.find_by_id(1)
    assert_instance_of Invoice, repository.find_by_id(1)
    assert repository.find_by_id(2)
    assert_instance_of Invoice, repository.find_by_id(2)
    assert_nil repository.find_by_id(50)
  end

  def test_it_can_return_all_invoices_that_match_customer_id
    assert repository.find_all_by_customer_id(1)
    assert repository.find_all_by_customer_id(2)
    assert_equal [], repository.find_all_by_customer_id(50)
  end

  def test_it_can_return_all_invoices_that_match_merchant_id
    assert repository.find_all_by_merchant_id(101)
    assert repository.find_all_by_merchant_id(102)
    assert_equal [], repository.find_all_by_merchant_id(50)
  end

  def test_it_can_return_all_invoices_that_match_status
    assert_equal 2, repository.find_all_by_status(:pending).count
    assert_equal [], repository.find_all_by_status(:something)
  end

end