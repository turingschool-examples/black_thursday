require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

   def setup
    parent = Minitest::Mock.new
    @invoice_item = InvoiceItemRepository.new('./data/test_invoice_items.csv', parent)
  end

  def test_it_exists
    assert InvoiceItemRepository.new
  end

  def test_it_initializes_with_a_file
    assert InvoiceItemRepository.new('./data/test_items.csv')
  end

  def test_it_has_custom_inspect
    assert_equal "#<InvoiceItemRepository: 74 rows>", @invoice_item.inspect
  end

  def test_find_invoice_by_id_calls_parent
    @invoice_item.parent.expect(:find_invoice_by_id, nil, [5])
    @invoice_item.find_invoice_by_id(5)
    @invoice_item.parent.verify
  end

  def test_find_item_by_id_calls_parent
    @invoice_item.parent.expect(:find_item_by_id, nil, [5])
    @invoice_item.find_item_by_id(5)
    @invoice_item.parent.verify
  end

  def test_it_turns_file_contents_to_CSV_object
    assert_equal CSV, @invoice_item.file_contents.class
  end

  def test_it_generates_array_of_item_objects_from_csv_object
    assert @invoice_item.all.all?{|row| row.class == InvoiceItem}
  end

  def test_it_calls_id_of_item_object
    assert_equal 1, @invoice_item.all[0].id
  end

  def test_it_retrieves_all_item_objects
    assert_equal InvoiceItem, @invoice_item.all[0].class
    assert_equal 74, @invoice_item.all.count
  end

  def test_item_ids_are_uniq
    ids = @invoice_item.all {|row| row[:id]}
    assert_equal ids, ids.uniq
  end

  def test_it_finds_item_by_id
    id = 1
    item = @invoice_item.find_by_id(id)
    assert_equal InvoiceItem, item.class
    assert_equal id, item.id
  end

  def test_it_returns_nil_if_id_not_found
    id = 123
    item = @invoice_item.find_by_id(id)
    assert_equal nil, item
  end

  def test_it_finds_all_items_by_item_id
    item_id = 263529264
    assert_equal Fixnum, item_id.class
    invoice_items = @invoice_item.find_all_by_item_id(item_id)
    assert_equal 2, invoice_items.map{|item| item.item_id}.count
  end

  def test_it_returns_nil_if_item_id_not_found
    item_id = 8675309
    invoice_item = @invoice_item.find_all_by_item_id(item_id)
    assert_equal [], invoice_item
  end

  def test_it_finds_items_by_invoice_id
    invoice_id = 1
    invoice_items = @invoice_item.find_all_by_invoice_id(invoice_id)
    assert_equal InvoiceItem, invoice_items.first.class
    assert_equal 8, invoice_items.map{|item| item.invoice_id}.count
  end

  def test_it_returns_empty_array_if_invoice_id_not_found
    invoice_id = 8675309
    invoice_item = @invoice_item.find_all_by_invoice_id(invoice_id)
    assert_equal [], invoice_item
  end

end
