require "./test/test_helper"
require "./lib/invoice_item"

class InvoiceItemTest < Minitest::Test

  def setup
    @hash = {:id => "2",
             :item_id => "1214152",
             :invoice_id => "2235675",
             :quantity => "23",
             :unit_price => "1241",
             :created_at => "2012-03-27 14:54:09 UTC",
             :updated_at => "2012-03-27 14:54:09 UTC"}
  end

  def test_it_can_get_the_id
    assert_equal 2, InvoiceItem.new(@hash).id
  end

  def test_it_can_get_the_item_id
    assert_equal 1214152, InvoiceItem.new(@hash).item_id
  end

  def test_it_can_get_the_invoice_id
    assert_equal 2235675, InvoiceItem.new(@hash).invoice_id
  end

  def test_it_can_get_the_quantity
    assert_equal 23, InvoiceItem.new(@hash).quantity
  end

  def test_it_can_get_the_unit_price
    assert_equal BigDecimal.new(12.41,4), InvoiceItem.new(@hash).unit_price
    assert_instance_of BigDecimal, InvoiceItem.new(@hash).unit_price
  end

  def test_it_can_find_the_created_date
    time = Time.strptime("2012-03-27 14:54:09 UTC", "%Y-%m-%d %H:%M:%S %z")
    assert_equal time, InvoiceItem.new(@hash).created_at
  end

  def test_it_can_find_the_updated_date
    time = Time.strptime("2012-03-27 14:54:09 UTC", "%Y-%m-%d %H:%M:%S %z")
    assert_equal time, InvoiceItem.new(@hash).updated_at
  end

  def test_it_can_get_the_unit_price_to_dollars
    assert_equal 12.41, InvoiceItem.new(@hash).unit_price_to_dollars
    assert_instance_of Float, InvoiceItem.new(@hash).unit_price_to_dollars
  end

end
