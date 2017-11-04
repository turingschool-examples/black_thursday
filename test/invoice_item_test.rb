require_relative 'test_helper'
require 'pry'


class InvoiceItemTest < MiniTest::Test

  def setup
    invoice_item = InvoiceItemRepository.new
    invoice_item.from_csv("./test/fixtures/invoice_items.csv")
    @invoice_items = @sales_engine.invoice_item
  end

  def test_that_invoice_item_returns_all

    assert_equal @invoice_items, @invoice_items.all
  end

end
