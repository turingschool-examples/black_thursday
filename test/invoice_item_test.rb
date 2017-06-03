require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/invoice_item'
require './lib/invoice_item_repository'
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
end
