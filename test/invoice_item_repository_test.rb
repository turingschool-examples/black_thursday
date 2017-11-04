require './test/test_helper'
require './lib/invoice_item_repository'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :ir

  def setup
    parent = mock('parent')
    invoice_items = [{
      :id => "3",
      :item_id => "223454178",
      :invoice_id => "7",
      :quantity => "9",
      :unit_price => "400",
      :created_at => "2012-03-27",
      :updated_at => "2012-04-27"
    },{
      :id => "4",
      :item_id => "22454278",
      :invoice_id => "2",
      :quantity => "4",
      :unit_price => "10001",
      :created_at => '2016-01-11 09:34:06 UTC',
      :updated_at => '2007-06-04 21:35:10 UTC'
    }]
    @ir = InvoiceItemRepository.new(invoice_items, parent)
  end

  def test_setup_exists
    assert_instance_of InvoiceItemRepository, ir
  end

  def test_it_can_find_all_merchants
    assert_equal 2, ir.all.count
  end

  def test_it_can_find_invoice_items_by_id
    assert_equal 3, ir.find_by_id("3").item_id
  end

  def test_it_can_find_invoice_items_by_item_id
    skip
    assert_equal 223454178, ir.find_by_id("223454178").item_id
    assert_equal 22454278, ir.find_by_id("22454278").item_id
  end

  def test_it_can_find_invoice_items_by_invoice_id
    skip
    assert_equal 7, ir.find_by_id("7").id
    assert_equal 2, ir.find_by_id("2").id
  end
end
