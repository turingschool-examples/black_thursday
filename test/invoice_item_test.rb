require './test/test_helper'
require './lib/invoice_item'
require './lib/sales_engine'

class InvoiceItemTest < Minitest::Test
  include SalesEngineTestSetup

  def setup
    super
    @ii = @se.invoice_items
  end

  def test_invoice_item_exists
    assert_equal 1, @ii.all.first.id
    assert_equal 263519844, @ii.all.first.item_id
    assert_equal 1, @ii.all.first.invoice_id
    assert_equal 5, @ii.all.first.quantity
    assert_equal 0.13635e3, @ii.all.first.unit_price
    assert @ii.all.first.created_at
    assert @ii.all.first.updated_at
  end

end
