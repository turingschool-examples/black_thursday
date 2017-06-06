require_relative 'test_helper.rb'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'
require 'pry'

class InvoiceItemTest < Minitest::Test

  def test_new_instance
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)

    assert_instance_of InvoiceItem, iir.contents[1]
  end

  def test_return_id_integer
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)

    assert_equal 13, iir.contents[13].id
  end

  def test_return_invoice_id
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)

    assert_equal 5, iir.contents[24].invoice_id
  end

  def test_return_item_id
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)

    assert_equal 263537372, iir.contents[41].item_id
  end

  def test_return_quantity
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)

    assert_equal 5, iir.contents[1].quantity
  end

  def test_return_unit_price
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)

    assert_equal 42.64, iir.contents[14].unit_price.to_f
  end

  def test_return_created_at
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)

    assert_equal "2012-03-27 14:54:09 UTC", iir.contents[1].created_at.to_s
  end

  def test_return_updated_at
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)

    assert_equal "2012-03-27 14:54:10 UTC", iir.contents[41].updated_at.to_s
  end

  def test_unit_price_to_dollars
    iir = InvoiceItemRepository.new("./test/data/invoice_items_fixture.csv", self)

    assert_equal 707.83, iir.contents[41].unit_price_to_dollars(41)
  end
end
