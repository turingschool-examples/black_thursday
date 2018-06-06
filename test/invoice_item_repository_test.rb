require './test_helper'
require './lib/invoice_item'
require './lib/invoice_item_repository'
require './lib/file_loader'
require './lib/sales_engine'
require 'bigdecimal'

class InvoiceItemRepositoryTest < MiniTest::Test
  def setup
    se = SalesEngine.from_csv({
      :items => "./data/mock.csv",
      :merchants => "./data/mock.csv",
      :invoices => "./data/mock.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/mock.csv",
      :customers => "./data/mock.csv"})

    @iir = se.invoice_items
  end

  def test_it_returns_array_of_all_invoices
    assert_equal 21830, @iir.all.length
  end

  def test_find_invoice_item_by_id
    found_invoice_item = @iir.find_by_id(10)

    assert_equal 263523644, found_invoice_item.item_id
    assert_equal 2, found_invoice_item.invoice_id
  end

  def test_it_returns_nil_if_invoice_item_id_is_not_present
    assert_nil @iir.find_by_id(200000)
  end

  def test_it_can_find_all_by_item_id
    assert_equal 11, @iir.find_all_by_item_id(263408101).length
    assert_instance_of InvoiceItem, @iir.find_all_by_item_id(263408101).first
  end

  def test_it_returns_empty_array_if_item_id_is_nonexistant
    assert_equal [], @iir.find_all_by_item_id(10)
    assert @iir.find_all_by_item_id(10).empty?
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 3, @iir.find_all_by_invoice_id(100).length
    assert_instance_of InvoiceItem, @iir.find_all_by_invoice_id(100).first
  end

  def test_it_returns_empty_array_if_invoice_id_is_nonexistant
    assert_equal [], @iir.find_all_by_invoice_id(1234567890)
    assert @iir.find_all_by_invoice_id(1234567890).empty?
  end

  def test_it_can_create_new_invoice_item
    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now}

    @iir.create(attributes)

    new_invoice_item = @iir.find_by_id(21831)
    assert_equal 7, new_invoice_item.item_id
  end

  def test_it_can_update_invoice_item
    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now}

    @iir.create(attributes)
    new_invoice_item = @iir.find_by_id(21831)
    original_time = new_invoice_item.updated_at
    new_attributes = {:quantity => 13}
    @iir.update(21831, new_attributes)
    updated_invoice_item = @iir.find_by_id(21831)

    assert_equal 13, updated_invoice_item.quantity
    assert_equal 7, updated_invoice_item.item_id
    assert updated_invoice_item.updated_at > original_time
  end

  def test_it_can_update_invoice_item
    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now}

    @iir.create(attributes)
    new_invoice_item = @iir.find_by_id(21831)
    original_time = new_invoice_item.updated_at

    new_attributes = {
      :id => 22000,
      :item_id => 32,
      :invoice_id => 53,
      :created_at => Time.now}

    @iir.update(21831, new_attributes)
    updated_invoice_item = @iir.find_by_id(21831)

    assert_nil @iir.find_by_id(22000)
    refute_equal 22000, updated_invoice_item.id
    refute_equal 53, updated_invoice_item.invoice_id
    refute_equal Time.now, updated_invoice_item.created_at
  end

  def test_it_does_nothing_if_you_try_to_update_nonexistant_invoice_item
    assert_nil @iir.update(200000, {})
  end

  def test_it_can_delete_invoice_item_by_id
    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99,4),
      :created_at => Time.now,
      :updated_at => Time.now}

    @iir.create(attributes)
    assert_instance_of InvoiceItem, @iir.find_by_id(21831)
    @iir.delete(21831)
    assert_nil @iir.find_by_id(21831)
  end

  def test_it_returns_nil_if_you_try_to_delete_nonexistant_ivoice_item
    assert_nil @iir.delete(22000)
  end
end
