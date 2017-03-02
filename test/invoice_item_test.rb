require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test

  attr_reader :repo, :invoice_item

  def setup
    @invoice_item = InvoiceItem.new( {
    :id => 1,
    :item_id => 263519844,
    :invoice_id => 1,
    :quantity => 5,
    :unit_price => 13635,
    :created_at => "2012-03-27 14:54:09 UTC",
    :updated_at => "2012-03-27 14:54:09 UTC"
    }, repo)
  end

  def test_it_finds_an_invoice_item_id
    assert_equal 1, invoice_item.id
  end

  def test_it_finds_an_item_id
    assert_equal 263519844, invoice_item.item_id
  end

  def test_it_finds_an_invoice_id
    assert_equal 1, invoice_item.invoice_id
  end

  def test_it_finds_a_quantity
    assert_equal 5, invoice_item.quantity
  end

  def test_it_finds_a_unit_price
    assert_equal BigDecimal, invoice_item.unit_price.class
  end

  def test_it_finds_a_created_at_date
    assert_equal Time, invoice_item.created_at.class
  end

  def test_it_finds_an_updated_at_date
    assert_equal Time, invoice_item.updated_at.class
  end

end
