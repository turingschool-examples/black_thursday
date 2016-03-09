require 'simplecov'
SimpleCov.start
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'

class InvoiceItemClassTest < Minitest::Test

  def setup
    sales_engine = "sales engine"
    @invoice_item1 = InvoiceItem.new(sales_engine, {:id => "1",
      :item_id => "263519844",
      :invoice_id => "1",
      :quantity => "5",
      :unit_price => "13635",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"})

      @invoice_item2 = InvoiceItem.new(sales_engine, {:id => "2",
        :item_id => "29844",
        :invoice_id => "2",
        :quantity => "4",
        :unit_price => "105",
        :created_at => "2012-03-27 14:54:09 UTC",
        :updated_at => "2012-03-27 14:54:09 UTC"})
  end

  def test_can_get_invoice_item_id
    assert_equal 1, @invoice_item1.id
    assert_equal 2, @invoice_item2.id
  end

  def test_can_get_item_id_from_invoice_item
    assert_equal 263519844, @invoice_item1.item_id
    assert_equal 29844, @invoice_item2.item_id
  end

  def test_can_get_invoice_id_from_invoice_item
    assert_equal 1, @invoice_item1.invoice_id
    assert_equal 2, @invoice_item2.invoice_id
  end

  def test_can_get_unit_price_for_invoice_item
    assert_equal 136.35, @invoice_item1.unit_price
    assert_equal 1.05, @invoice_item2.unit_price
  end

  def test_can_get_time_object_invoice_item_was_created_and_updated
    assert_equal Time, @invoice_item1.created_at.class
    assert_equal Time, @invoice_item1.updated_at.class
  end


end
