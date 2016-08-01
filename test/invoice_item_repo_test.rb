require_relative './test_helper'
require_relative '../lib/invoice_item_repo'

class InvoiceItemRepoTest < Minitest::Test
  def test_add_invoice_items_and_access_them
    iir = InvoiceItemRepo.new
    iir.add_invoice_item({
       :id => 123,
       :item_id => 234,
       :invoice_id => 345,
       :quantity => 7,
       :unit_price => 30000,
       :created_at => Time.now,
       :updated_at => Time.now})
    assert_equal 1, iir.all.count
    assert_equal 7, iir.all.first.quantity
  end

  def test_find_by_id
    iir = InvoiceItemRepo.new
    iir.add_invoice_item({
      :id => 123,
      :item_id => 234,
      :invoice_id => 345,
      :quantity => 7,
      :unit_price => 30000,
      :created_at => Time.now,
      :updated_at => Time.now})
    iir.add_invoice_item({
      :id => 124,
      :item_id => 678,
      :invoice_id => 789})
    assert_equal 300.00, iir.find_by_id(123).unit_price
  end

  def test_fail_at_find_by_id
    iir = InvoiceItemRepo.new
    iir.add_invoice_item({
      :id => 123,
      :item_id => 234,
      :invoice_id => 345,
      :quantity => 7,
      :unit_price => 30000,
      :created_at => Time.now,
      :updated_at => Time.now})
    iir.add_invoice_item({
      :id => 124,
      :item_id => 678,
      :invoice_id => 789})
    assert_equal nil, iir.find_by_id(0)
  end

  def test_find_all_by_item_id
    iir = InvoiceItemRepo.new
    iir.add_invoice_item({
      :id => 123,
      :item_id => 234,
      :invoice_id => 345,
      :quantity => 7,
      :unit_price => 30000,
      :created_at => Time.now,
      :updated_at => Time.now})
    iir.add_invoice_item({
      :id => 124,
      :item_id => 678,
      :invoice_id => 789})
    iir.add_invoice_item({
      :id => 124,
      :item_id => 678,
      :invoice_id => 126})
      found_invoice_items = iir.find_all_by_item_id(678)
      assert_equal 2, found_invoice_items.count
      assert_equal 124, found_invoice_items.first.id
      assert_equal [], iir.find_all_by_item_id(1)
  end

  def test_find_all_by_invoice_id
    iir = InvoiceItemRepo.new
    iir.add_invoice_item({
      :id => 123,
      :item_id => 234,
      :invoice_id => 345,
      :quantity => 7,
      :unit_price => 30000,
      :created_at => Time.now,
      :updated_at => Time.now})
    iir.add_invoice_item({
      :id => 124,
      :item_id => 678,
      :invoice_id => 789})
    iir.add_invoice_item({
      :id => 125,
      :item_id => 678,
      :invoice_id => 789})
    found_invoice_items = iir.find_all_by_invoice_id(789)
    assert_equal 2, found_invoice_items.count
    assert_equal 789, found_invoice_items.first.invoice_id
    assert_equal [], iir.find_all_by_invoice_id(1)
  end

end
