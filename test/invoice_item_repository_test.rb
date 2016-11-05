require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader   :repository,
                :sales_engine

  def setup
    #@sales_engine = SalesEngine.from_csv(
    #{:invoice_items => "./fixture/invoice_items.csv"})
    #@repository = sales_engine.invoices
  end

  def test_it_can_create_invoice_repository
    skip
    assert repository
  end

  def test_all_returns_instances_of_invoices
    skip
    assert_instance_of Array, repository.all
  end

  def test_it_can_return_instance_of_invoice_with_matching_id
    skip
    assert repository.find_by_id()
    assert_instance_of InvoiceItem, repository.find_by_id()
    assert repository.find_by_id()
    assert_instance_of InvoiceItem, repository.find_by_id()
    assert_nil repository.find_by_id()
  end

  def test_it_can_return_all_invoices_that_match_item_id
    skip
    assert repository.find_all_by_item_id()
    assert repository.find_all_by_item_id()
    assert_equal [], repository.find_all_by_item_id()
  end

  def test_it_can_return_all_invoices_that_match_invoice_id
    skip
    assert repository.find_all_by_invoice_id()
    assert repository.find_all_by_invoice_id()
    assert_equal [], repository.find_all_by_invoice_id()
  end

  def test_that_an_invoice_repo_knows_who_its_parent_is
    skip
    assert_equal sales_engine, repository.parent
    assert_instance_of SalesEngine, repository.parent
  end

end