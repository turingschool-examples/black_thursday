require_relative 'test_helper'
require_relative '../lib/invoice_item_repo'
require 'bigdecimal'

class InvoiceItemRepoTest < Minitest::Test
  def test_invoice_item_repo_class_exists
    assert_instance_of InvoiceItemRepo, InvoiceItemRepo.new('./data/invoice_items.csv')
  end

  def test_invoice_item_repo_can_populate_with_invoice_objects_and_attributes
    invoice_item_repo = InvoiceItemRepo.new('./data/invoice_items.csv')
    assert_equal InvoiceItem, invoice_item_repo.all.first.class
    assert_equal 1, invoice_item_repo.all.first.id
    assert_equal 263519844, invoice_item_repo.all.first.item_id
    assert_equal 1, invoice_item_repo.all.first.invoice_id
    assert_equal 5, invoice_item_repo.all.first.quantity
    assert_equal 136.35, invoice_item_repo.all.first.unit_price
    assert_instance_of Time, invoice_item_repo.all.first.created_at
    assert_instance_of Time, invoice_item_repo.all.first.updated_at
  end

  def test_invoice_item_repo_can_find_all_instances_of_invoice_items
    invoice_item_repo = InvoiceItemRepo.new('./data/invoice_items.csv')
    assert_equal 21830, invoice_item_repo.all.count
  end

  def test_invoice_item_repo_can_find_by_invoice_id
    invoice_item = InvoiceItemRepo.new('./data/invoice_items.csv').find_by_id(1)
    assert_equal 1, invoice_item.id
  end

  def test_invoice_item_repo_returns_nil_if_invoice_id_does_not_exist
    invoice_item = InvoiceItemRepo.new('./data/invoice_items.csv').find_by_id(2132131)
    assert_equal nil, invoice_item
  end

  def test_invoice_item_repo_can_find_all_by_item_id
    invoice_item = InvoiceItemRepo.new('./data/invoice_items.csv').find_all_by_item_id(263519844)
    assert_equal 164, invoice_item.count
  end

  def test_invoice_item_repo_can_find_all_by_invoice_id
    invoice_item = InvoiceItemRepo.new('./data/invoice_items.csv').find_all_by_invoice_id(1)
    assert_equal 8, invoice_item.count
  end
end
