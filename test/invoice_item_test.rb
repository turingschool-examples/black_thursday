require_relative 'test_helper'
require './lib/invoice_item'
require 'pry'

class InvoiceItemTest < Minitest::Test
  def setup
    @ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
      })
  end

  def test_it_exist
    assert_instance_of InvoiceItem, @ii
  end

  def test_it_returns_id
    assert_equal 6, @ii.id
  end
end
