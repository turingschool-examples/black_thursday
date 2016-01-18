require_relative '../lib/invoice_item'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class InvoiceItemTest < Minitest::Test

  attr_reader :repo

  def test_class_exist
    assert InvoiceItem
  end

  def setup
    @repo = InvoiceItem.new({
                    :id => 6,
                    :item_id => 7,
                    :invoice_id => 8,
                    :quantity => 1,
                    :unit_price => BigDecimal.new(1099),
                    :created_at => "2016-01-11 10:37:09 UTC",
                    :updated_at => "2016-01-11 10:37:09 UTC"
                  })
  end

  def test_that_unit_price_to_dollars_exist
    assert InvoiceItem.method_defined? :unit_price_to_dollars
  end

  def test_that_invoice_items_attributes_can_be_called
    assert_equal     6, repo.id
    assert_equal     7, repo.item_id
    assert_equal     8, repo.invoice_id
    assert_equal     1, repo.quantity
    assert_equal 10.99, repo.unit_price_to_dollars
    assert_equal Time.parse("2016-01-11 10:37:09 UTC"), repo.created_at
    assert_equal Time.parse("2016-01-11 10:37:09 UTC"), repo.updated_at
  end



end
