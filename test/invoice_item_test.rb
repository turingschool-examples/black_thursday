require 'bigdecimal'
require_relative 'test_helper.rb'
require_relative '../lib/invoice_item.rb'
require_relative '../lib/sales_engine.rb'
require_relative './master_hash.rb'

class InvoiceItemTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.god_hash
    @sales_engine = SalesEngine.new(test_engine)
    @invoice_item = InvoiceItem.new({
      :id          => 1,
      :item_id     => 263_519_844,
      :invoice_id  => 1,
      :quantity    => 5,
      :unit_price  => BigDecimal.new(13635,5),
      :created_at  => '2012-03-27 14:54:09 UTC',
      :updated_at  => '2012-03-27 14:54:09 UTC',
      }, @sales_engine.invoice_items)
  end

  def test_it_exists
    invoice_item = @invoice_item

    assert_instance_of InvoiceItem, invoice_item
  end

  def test_it_has_attributes
    invoice_item = @invoice_item

    assert_equal 1, invoice_item.id
    assert_equal 263_519_844, invoice_item.item_id
    assert_equal 1, invoice_item.invoice_id
    assert_equal 5, invoice_item.quantity
    assert_equal 136.35, invoice_item.unit_price
    assert_instance_of Time, invoice_item.created_at
    assert_instance_of Time, invoice_item.updated_at
  end

  def test_it_can_have_different_attributes
    invoice_item = InvoiceItem.new({
      :id          => 13,
      :item_id     => 999_519_844,
      :invoice_id  => 14,
      :quantity    => 25,
      :unit_price  => BigDecimal.new(63635,5),
      :created_at  => '2012-03-27 14:54:09 UTC',
      :updated_at  => '2012-03-27 14:54:09 UTC',
      }, @sales_engine.invoice_items)

    assert_equal 13, invoice_item.id
    assert_equal 999_519_844, invoice_item.item_id
    assert_equal 14, invoice_item.invoice_id
    assert_equal 25, invoice_item.quantity
    assert_equal 636.35, invoice_item.unit_price
    assert_instance_of Time, invoice_item.created_at
    assert_instance_of Time, invoice_item.updated_at
  end

  def test_unit_price_converts_to_dollar
    invoice_item = @invoice_item

    assert_equal 136.35, invoice_item.unit_price_to_dollars
  end
end
