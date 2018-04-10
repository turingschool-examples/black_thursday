require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository'
require 'time'

class InvoiceItemRepositoryTest < Minitest::Test
  def test_exists
    iir = InvoiceItemRepository.new ('./test/invoice_items.csv')

    assert_instance_of InvoiceItemRepository, iir
  end

  def test_it_can_load_all_invoice_items
    iir = InvoiceItemRepository.new ('./test/invoice_items.csv')

    assert_equal 199, iir.all.count
    assert_equal 1, iir.all.first.id
    assert_equal 263519844, iir.all.first.item_id
    assert_equal 1, iir.all.first.invoice_id
    assert_equal 5, iir.all.first.quantity
    assert_equal 136.35, iir.all.first.unit_price
    # assert_equal "2012-03-27 14:54:09 UTC", iir.all.first.created_at
    # assert_equal "2012-03-27", iir.all.first.updated_at
  end

  def test_it_can_find_by_id
    iir = InvoiceItemRepository.new ('./test/invoice_items.csv')

    result = iir.find_by_id(5)

    assert_equal 5, result.id
    assert_equal 263515158, result.item_id
    assert_equal 1, result.invoice_id
    assert_equal 7, result.quantity
  end

  def test_it_can_find_by_returns_nil_for_invalid_id
    iir = InvoiceItemRepository.new ('./test/invoice_items.csv')

    result = iir.find_by_id(000000)

    assert_nil result
  end

  def test_it_can_find_all_by_item_id
    iir = InvoiceItemRepository.new ('./test/invoice_items.csv')


    result =  iir.find_all_by_item_id(263515158)
    assert_equal 5, result.first.id
    assert_equal 1, result.first.invoice_id
    assert_equal 7, result.first.quantity
    assert_equal 79140 / 100.0, result.first.unit_price
  end

  def test_it_returns_empty_array_for_invalid_item_id
    iir = InvoiceItemRepository.new ('./test/invoice_items.csv')


    result =  iir.find_all_by_item_id(00000000)
    assert_equal [], result
  end

  def test_it_can_find_all_by_invoice_id
    iir = InvoiceItemRepository.new ('./test/invoice_items.csv')


    result =  iir.find_all_by_invoice_id(1)
    assert_equal 8, result.count
    assert_equal 1, result.first.id
    assert_equal 263519844, result.first.item_id
    assert_equal 5, result.first.quantity
    assert_equal 13635 / 100.0, result.first.unit_price
  end

  def test_it_returns_empty_array_for_invalid_invoice_id
    iir = InvoiceItemRepository.new ('./test/invoice_items.csv')


    result =  iir.find_all_by_invoice_id(00000)
    assert_equal [], result
  end

  def test_it_can_create_new_id
    iir = InvoiceItemRepository.new ('./test/invoice_items.csv')

    assert_equal 200, iir.create_new_id
  end
  
end
