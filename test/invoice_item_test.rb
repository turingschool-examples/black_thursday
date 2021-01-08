require 'bigdecimal'
require './test/test_helper'

class InvoiceItemTest < Minitest::Test

  def setup
    @repository = mock
    @data = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => "2016-01-11 11:51:37 UTC",
      :updated_at => Time.now}, @repository)
  end
  def test_it_exists
      assert_instance_of InvoiceItem, @data
    end

  def test_it_has_attributes
    assert_equal 6, @data.id
    assert_equal 7, @data.item_id
    assert_equal 8, @data.invoice_id
    assert_equal 1, @data.quantity
    assert_equal 10.99, @data.unit_price
    expected = Time.parse("2016-01-11 11:51:37 UTC")
    assert_equal expected, @data.created_at
    assert_instance_of Time, @data.updated_at
  end

end
