require_relative 'test_helper'
require_relative '../lib/invoice_item'
require 'bigdecimal'
require 'time'

class InvoiceItemTest < Minitest::Test

  def setup
    invoice_item_info_1 = ({
      :id         => "1",
      :item_id    => "263519844",
      :invoice_id => "1",
      :quantity   => "5",
      :unit_price => "2500",
      :created_at => "2016-11-01 11:38:28 -0600",
      :updated_at => "2016-11-01 14:38:28 -0600"
    })
    invoice_item_info_2 = ({
      :id         => nil,
      :item_id    => nil,
      :invoice_id => nil,
      :quantity   => nil,
      :unit_price => nil,
      :created_at => "2016-11-01 11:38:28 -0600",
      :updated_at => "2016-11-01 14:38:28 -0600"
    })
    parent = Minitest::Mock.new
    @invoice_item1 = InvoiceItem.new(invoice_item_info_1, parent)
    @invoice_item2 = InvoiceItem.new(invoice_item_info_2, parent)
    @invoice_item3 = InvoiceItem.new()
    @invoice_item4 = InvoiceItem.new({})
  end

  def test_it_exists
    assert @invoice_item1
  end

  def test_it_initializes_id
    assert_equal 1, @invoice_item1.id
  end

  def test_it_initializes_item_item_id
    assert_equal 263519844, @invoice_item1.item_id
  end

  def test_it_initializes_invoice_id
    assert_equal 1, @invoice_item1.invoice_id
  end

  def test_it_initializes_item_unit_price
    expected = BigDecimal.new(0.25E2,9)
    assert_equal expected, @invoice_item1.unit_price
  end

  def test_it_initializes_item_quantity
    assert_equal 5, @invoice_item1.quantity
  end

  def test_it_initializes_item_create_time
    expected = Time.parse("2016-11-01 11:38:28 -0600")
    assert_equal expected, @invoice_item1.created_at
  end

  def test_it_initializes_item_update_time
    expected = Time.parse("2016-11-01 14:38:28 -0600")
    assert_equal expected, @invoice_item1.updated_at
  end

  def test_it_returns_unit_price_in_dollars
    assert_equal 25.01, @invoice_item1.unit_price_to_dollars("2501")
  end

  def test_it_returns_zero_if_there_is_no_id_given
    assert_equal 0, @invoice_item2.id
  end

  def test_it_returns_zero_if_there_is_no__item_id_given
    assert_equal 0, @invoice_item2.item_id
  end

  def test_it_returns_zero_if_there_is_quantity_given
    assert_equal 0, @invoice_item2.quantity
  end

  def test_it_returns_zero_if_there_is_no_unit_price_given
    assert_equal 0, @invoice_item2.unit_price
  end

  def test_it_returns_blank_item_object_if_no_data_passed
    assert_equal InvoiceItem, @invoice_item3.class
    assert_nil @invoice_item3.id
    assert_nil @invoice_item3.created_at
    assert_nil @invoice_item3.unit_price
  end

  def test_it_returns_blank_item_object_if_empty_hash_passed
    assert_equal InvoiceItem, @invoice_item4.class
    assert_nil @invoice_item4.id
    assert_nil @invoice_item4.unit_price
    assert_nil @invoice_item4.item_id
  end

end
