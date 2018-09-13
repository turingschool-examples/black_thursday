require_relative '../test/test_helper'
require_relative '../lib/invoice_item_repository'


class InvoiceItemRepositoyTest < Minitest::Test

  def setup
    @iir = InvoiceItemRepositoy.new
    @args1 = {
        :id => "6",
        :item_id => "7",
        :invoice_id => "8",
        :quantity => "1",
        :unit_price => "1099",
        :created_at => "2016-01-11 09:34:06 UTC",
        :updated_at => "2016-01-11 09:34:06 UTC"
        }
    @args2 = {
        :id => "7",
        :item_id => "1",
        :invoice_id => "10",
        :quantity => "5",
        :unit_price => "1199",
        :created_at => "2016-01-11 09:34:06 UTC",
        :updated_at => "2016-01-11 09:34:06 UTC"
        }
  end

  def test_it_can_create
    @iir.create(@args1)
    @iir.create(@args2)
    assert_equal 2, @iir.all.count
    assert_equal 6, @iir.all[0].id
  end

  def test_it_can_return_all_by_invoice_id
    @iir.create(@args1)
    @iir.create(@args2)
    assert_equal 1, @iir.find_all_by_invoice_id(8).length
  end

  def test_it_can_return_all_by_item_id
    @iir.create(@args1)
    @iir.create(@args2)
    assert_equal 1, @iir.find_all_by_item_id(1).length
  end


end
