require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < MiniTest::Test
  attr_reader :iir

  def setup
    invoice_item_helper = TestHelper.new.invoice_items
    @iir = InvoiceItemRepository.new(invoice_item_helper)
  end

  def test_it_returns_array_of_all_invoice_item_instances
    assert_equal Array, iir.all.class
  end

  def test_it_returns_all_invoice_item_instances
    assert_equal 2, iir.all.length
  end

  def test_it_finds_invoice_item_by_id
    assert_equal "9", iir.find_by_id(2).quantity
  end

  def test_it_returns_nil_if_id_does_not_exist
    assert_equal nil, iir.find_by_id(3)
  end

  def test_find_all_by_item_id_finds_all_matching_items
    assert_equal 1, iir.find_all_by_item_id(263519844).length
  end

  def test_find_all_by_item_id_returns_empty_arr_if_match_does_exist
    assert_equal [], iir.find_all_by_item_id(8888)
  end

  def test_find_all_by_invoice_id_finds_all_matching_items
    assert_equal 2, iir.find_all_by_invoice_id(1).length
  end

  def test_find_all_by_invoice_id_returns_empty_arr_if_match_does_not_exist
    assert_equal [], iir.find_all_by_invoice_id(5)
  end

  def test_it_can_be_inspected
    assert_equal "#<InvoiceItemRepository 2 rows>", iir.inspect
  end
end
