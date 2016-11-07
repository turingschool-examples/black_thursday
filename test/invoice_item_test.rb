require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repo'
# require 'time'
# require 'bigdecimal'

class InvoiceItemTest < Minitest::Test

  attr_reader :data,
              :repo

  def setup
    @data = {:id => 6,
              :item_id => 7,
              :invoice_id => 8,
              :quantity => 1,
              :unit_price => 1099,
              :created_at => "2011-02-22 10:11:12 UTC",
              :updated_at => "2015-09-06 23:19:57 UTC"}
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
    assert_equal "2011-02-22 10:11:12 UTC", ii.created_at.to_s
  end

  def test_it_displays_when_it_was_updated
    ii = InvoiceItem.new(data, repo)
    assert_equal "2015-09-06 23:19:57 UTC", ii.updated_at.to_s
  end
  
  def test_it_has_a_unit_price_to_dollars
    ii = InvoiceItem.new(data, repo)
    assert_equal 10.99, ii.unit_price_to_dollars
  end
end
