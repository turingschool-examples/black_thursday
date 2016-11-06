require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'
require_relative '../lib/item_item_repo'

class InvoiceItemTest < Minitest::Test

  attr_reader :data,
              :repo

  def setup
    @data = ({:id => 6,
              :item_id => 7,
              :invoice_id => 8,
              :quantity => 1,
              :unit_price => BigDecimal.new(10.99, 4),
              :created_at => Time.now,
              :updated_at => Time.now})
    @repo = Minitest::Mock.new
  end

  def test_it_exists
    assert InvoiceItem.new(data, repo)
  end

  def test_it_has_a_class
    ii = InvoiceItem.new(data, repo)
    assert_equal InvoiceItem, ii.class
  end

  def test_it_has_an_id
    ii = InvoiceItem.new(data, repo)
    assert_equal 6, ii.id
  end

  def test_it_has_an_item_id
    ii = InvoiceItem.new(data, repo)
    assert_equal 7, ii.item_id
  end

  def test_it_has_an_invoice_id
    ii = InvoiceItem.new(data, repo)
    assert_equal 8, ii.invoice_id
  end

  def test_it_has_a_quantity
    ii = InvoiceItem.new(data, repo)
    assert_equal 1, ii.quantity
  end

  def test_it_has_a_unit_price
    ii = InvoiceItem.new(data, repo)
    assert_equal BigDecimal.new(10.99, 4), ii.unit_price
  end

  def test_it_displays_when_it_was_created
    ii = InvoiceItem.new(data, repo)
    assert_equal "2016-01-11 20:59:20 UTC", ii.created_at
  end

  def test_it_displays_when_it_was_updated
    ii = InvoiceItem.new(data, repo)
    assert_equal Time.now, ii.updated_at
  end
  
  def test_it_has_a_unit_price_to_dollars
    ii = InvoiceItem.new(data, repo)
    assert_equal Time.now, ii.unit_price_to_dollars
  end
end
