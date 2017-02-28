require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @iir = InvoiceItemRepository.new("parent")
    @iir.from_csv("./data/invoice_items_fixture.csv")
    @inv_item = @iir.all[0]
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_initializes_with_empty_array
    iir = InvoiceItemRepository.new("parent")
    assert_equal [], iir.all
  end

  def test_from_csv_populates_array
    iir = InvoiceItemRepository.new("parent")
    iir.from_csv("./data/invoice_items_fixture.csv")
    refute iir.all.empty?
    assert_instance_of InvoiceItem, iir.all[0]
  end

  def test_can_return_all_invoice_items
    assert_equal 30, @iir.all.length
  end

  def test_can_find_by_id
    found = @iir.find_by_id(7)
    not_found = @iir.find_by_id(9999999)

    assert_equal 7, found.id
    assert_nil not_found
  end

  def test_can_find_all_by_item_id
    found = @iir.find_all_by_item_id(263529264)
    not_found = @iir.find_all_by_item_id(9999999)

    assert_instance_of InvoiceItem, found[0]
    assert_equal 2, found.count
    assert_equal [], not_found
  end

  def test_can_find_all_by_invoice_id
    found = @iir.find_all_by_invoice_id(1)
    not_found = @iir.find_all_by_invoice_id(9999999)

    assert found.all?{ |invoice| invoice.is_a?(InvoiceItem)}
    assert_equal 8, found.count
    assert_equal [], not_found
  end
end
