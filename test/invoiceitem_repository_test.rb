require 'bigdecimal'
require 'csv'
require_relative 'test_helper'
require_relative '../lib/invoiceitem_repository'
require_relative '../lib/fileio'

# Test for InvoiceItem Repository class
class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    file_path = FileIO.load('./test/fixtures/test_invoice_items.csv')
    @inv_i_repo = InvoiceItemRepository.new(file_path)
    @time = Time.now
    @new_inv_item = @inv_i_repo.create(
      item_id:      '263454000',
      invoice_id:   '1',
      quantity:     '100',
      unit_price:   '23324',
      created_at:   '2012-03-27 14:54:09 UTC',
      updated_at:   '2014-03-27 14:54:09 UTC'
    )
  end

  def test_invoice_item_repository_exists
    assert_instance_of InvoiceItemRepository, @inv_i_repo
  end

  def test_creating_an_index_of_invoice_items_from_data
    assert_instance_of Hash, @inv_i_repo.invoice_items
    assert_instance_of InvoiceItem, @inv_i_repo.invoice_items[1]
    assert_instance_of InvoiceItem, @inv_i_repo.invoice_items[2]
    assert_instance_of InvoiceItem, @inv_i_repo.invoice_items[3]
  end

  def test_all_returns_an_array_of_all_invoice_item_instances
    assert_instance_of Array, @inv_i_repo.all
  end

  def test_can_find_by_id
    actual_one = @inv_i_repo.find_by_id(1)
    actual_two = @inv_i_repo.find_by_id(2)
    assert_instance_of InvoiceItem, actual_one
    assert_instance_of InvoiceItem, actual_two
    assert_equal 263519844, actual_one.item_id
    assert_equal 263454779, actual_two.item_id
  end

  def test_can_find_all_by_item_id
    actual = @inv_i_repo.find_all_by_item_id(263438971)
    result = actual.all? do |invoice_item|
      invoice_item.class == InvoiceItem
    end
    assert result
    ids = actual.map(&:id)
    assert_equal [12, 14], ids
  end

  def test_can_find_all_by_invoice_id
    actual = @inv_i_repo.find_all_by_invoice_id(1)
    result = actual.all? do |invoice_item|
      invoice_item.class == InvoiceItem
    end
    assert result
    ids = actual.map(&:id)
    assert_equal [1, 2, 3], ids
  end

  def test_it_can_generate_next_invoice_item_id
    expected = 16
    actual = @inv_i_repo.create_new_id
    assert_equal expected, actual
  end

  def test_can_create_new_invoice_item
    assert_instance_of InvoiceItem, @new_inv_item
    assert_equal 8, @inv_i_repo.invoice_items.count
    assert_equal 263454000, @inv_i_repo.invoice_items[15].item_id
    assert_equal 1, @inv_i_repo.invoice_items[15].invoice_id
    assert_equal 100, @inv_i_repo.invoice_items[15].quantity
    assert_equal 233.24, @inv_i_repo.invoice_items[15].unit_price
    assert_equal '2012-03-27 14:54:09 UTC', @inv_i_repo.invoice_items[15].created_at
    assert_equal '2014-03-27 14:54:09 UTC', @inv_i_repo.invoice_items[15].updated_at
  end

  def test_invoice_item_can_be_updated
    skip
    @inv_i_repo.update(263567475, name: 'Roly Poly Coley',
                              description: 'Best toy ever.',
                              unit_price: 15.00,
                              merchant_id: 12334135,
                              created_at: '2009-12-09 12:08:04 UTC',
                              updated_at: '2010-12-09 12:08:04 UTC')
    assert_equal 'Roly Poly Coley', @inv_i_repo.items[263567475].name
  end

  def test_invoice_item_can_be_deleted
    skip
    @inv_i_repo.delete(263567475)
    assert_equal 3, @inv_i_repo.items.count
    assert_nil @inv_i_repo.items[263567475]
  end

  def test_magic_spec_harness_method_works
    expected = "#<InvoiceItemRepository #{@inv_i_repo.invoice_items.size} rows>"
    assert_equal expected, @inv_i_repo.inspect
  end
end
