require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine.rb'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_that_it_exists
    ii = InvoiceItemRepository.new("./data/invoice_items.csv")

    assert_instance_of InvoiceItemRepository, ii
    assert_equal 21830, ii.all.count
  end

  def test_that_it_loads_an_array_invoice_item_instances
    ii = InvoiceItemRepository.new("./data/invoice_items.csv")

    assert_instance_of InvoiceItem, ii.invoice_items_array[464]
    assert_equal 21830, ii.all.count
  end

  def test_that_find_by_id_finds_invoice_items_by_id
    ii = InvoiceItemRepository.new("./data/invoice_items.csv")

    invoice_item = ii.find_by_id(10)

    assert_equal 263523644, invoice_item.item_id
    assert_equal 2, invoice_item.invoice_id
  end

  def test_that_find_by_id_returns_nil_when_nothing_found
    ii = InvoiceItemRepository.new("./data/invoice_items.csv")

    invoice_item = ii.find_by_id(1000000000)

    assert_nil invoice_item
  end

  def test_that_find_all_by_id_finds_all_invoice_items_by_id
    ii = InvoiceItemRepository.new("./data/invoice_items.csv")

    invoice_item_array = ii.find_all_by_item_id(263408101)

    assert_equal 11, invoice_item_array.length
    assert_instance_of InvoiceItem, invoice_item_array[5]
  end

  def test_that_find_all_by_id_returns_an_empty_array
    ii = InvoiceItemRepository.new("./data/invoice_items.csv")

    invoice_item_array = ii.find_all_by_item_id(263451258101)

    assert_equal [], invoice_item_array
  end

  def test_that_find_all_by_invoice_id_finds_all_invoice_items_by_invoice_id
    ii = InvoiceItemRepository.new("./data/invoice_items.csv")

    invoice_item_array = ii.find_all_by_invoice_id(100)

    assert_equal 3, invoice_item_array.length
    assert_instance_of InvoiceItem, invoice_item_array[2]
  end

  def test_that_find_all_by_invoice_id_returns_an_empty_array
    ii = InvoiceItemRepository.new("./data/invoice_items.csv")

    invoice_item_array = ii.find_all_by_invoice_id(263451258101)

    assert_equal [], invoice_item_array
  end

  def test_that_create_creates_a_new_invoice_item
    ii = InvoiceItemRepository.new("./data/invoice_items.csv")

    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }

    invoice_item_array = ii.create(attributes)
    new_invoice_item = ii.find_by_id(21831)

    assert_equal 7, new_invoice_item.item_id
    assert_equal 8, new_invoice_item.invoice_id
    assert_equal 1, new_invoice_item.quantity
    assert_instance_of BigDecimal, new_invoice_item.unit_price
    assert_instance_of Time, new_invoice_item.created_at
  end

  def test_that_update_updates_an_invoice_item
    ii = InvoiceItemRepository.new("./data/invoice_items.csv")

    old_invoice = ii.find_by_id(1)
<<<<<<< HEAD
    old_invoice_time = old_invoice.updated_at
=======
>>>>>>> a33524423e857984fe691490a07b9b74076983f8
    attributes = {:quantity => 1}
    assert_equal 5, old_invoice.quantity

    invoice_item_array = ii.update(1, attributes)

    new_invoice = ii.find_by_id(1)

    assert_equal 1, new_invoice.quantity
<<<<<<< HEAD
    assert old_invoice_time < new_invoice.updated_at
  end

  def test_that_delete_deletes_an_invoice_item
    ii = InvoiceItemRepository.new("./data/invoice_items.csv")

    ii.delete(1)
    expected = ii.find_by_id(1)

    assert_nil expected 
=======
    assert old_invoice.updated_at < new_invoice.updated_at
>>>>>>> a33524423e857984fe691490a07b9b74076983f8
  end
end
