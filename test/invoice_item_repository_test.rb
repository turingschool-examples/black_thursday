require './test/test_helper'
require './lib/invoice_item_repository'
require './lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test
  include SalesEngineTestSetup

  def setup
    super
    @iir = @se.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_all
    assert_equal 21830, @iir.all.count
    assert_equal 263519844, @iir.all.first.item_id
  end

  def test_find_by_id
    assert_instance_of InvoiceItem, @iir.find_by_id(1)
    assert_equal 263519844, @iir.find_by_id(1).item_id
  end

  def test_find_all_by_item_id
    assert_instance_of Array, @iir.find_all_by_item_id(263519844)
    assert_equal 5, @iir.find_all_by_item_id(263519844).first.quantity
  end

  def test_find_all_by_invoice_id
    assert_instance_of Array, @iir.find_all_by_invoice_id(1)
    assert_equal 1, @iir.find_all_by_invoice_id(1).first.id
  end

end
