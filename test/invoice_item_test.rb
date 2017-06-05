require_relative 'test_helper'
require_relative '../lib/invoice_item'


class InvoiceItemTest < Minitest::Test
  def setup
    @ii = InvoiceItem.new({
            :id => 6,
            :item_id => 7,
            :invoice_id => 8,
            :quantity => 1,
            :unit_price => BigDecimal.new(10.99, 4),
            :created_at => Time.now,
            :updated_at => Time.now
            }, self)
  end

  def test_it_starts_an_invoice_item_instance
    assert_instance_of InvoiceItem, @ii
  end

  def test_attr_reader_works
    assert_equal 6, @ii.id
  end

  def test_attr_reader_works_for_other_attributes
    assert_equal 8, @ii.invoice_id
  end

end
