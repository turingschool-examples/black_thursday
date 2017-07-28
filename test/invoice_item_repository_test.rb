require './test/test_helper'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exists
    iir = InvoiceItemRepository.new('./data/invoice_items_short.csv', self)

    assert_instance_of InvoiceItemRepository, iir
  end

  def test_it_initializes_with_populated_array
    iir = InvoiceItemRepository.new('./data/invoice_items_short.csv', self)

    assert_equal 10, iir.invoice_items.count
  end

  def test_it_can_return_all_invoice_items
    iir = InvoiceItemRepository.new('./data/invoice_items_short.csv', self)

    target = iir.all

    assert_equal Array, target.class
    assert_equal 10, target.count
  end

  def test_it_can_find_by_id
    iir = InvoiceItemRepository.new('./data/invoice_items_short.csv', self)

    target = iir.find_by_id(1)
    target_2 = iir.find_by_id(00000000)

    assert_equal 263519844, target.item_id
    assert_nil target_2
  end
end
