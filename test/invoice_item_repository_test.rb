require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < MiniTest::Test

  attr_reader     :iir

  def setup
    @iir = InvoiceItemRepository.new
    @iir.populate('./test/fixtures/invoice_items_fixture.csv')
  end

  def test_all_contatins_all_invoice_item_objects
    assert_instance_of Array, iir.all
    assert_instance_of InvoiceItem, iir.all.first
    assert_equal 4, iir.all.count
  end

  def test_can_find_invoice_item_by_id
    assert_instance_of InvoiceItem, iir.find_by_id(2)
    assert_nil iir.find_by_id(1000)
  end

  def test_can_find_invoice_item_by_item_id
    assert_instance_of Array, iir.find_all_by_item_id(263519844)
    assert_equal 1, iir.find_all_by_item_id(263519844).count
    assert_equal [], iir.find_all_by_item_id("Hello")
  end

  def test_can_find_invoice_item_by_invoice_id
    assert_instance_of Array, iir.find_all_by_invoice_id(1)
    assert_equal 4, iir.find_all_by_invoice_id(1).count
    assert_equal [], iir.find_all_by_invoice_id("Hello")
  end


end
