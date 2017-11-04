require_relative './test_helper'
require './lib/invoice_item_repository'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
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
    ir = InvoiceItemRepository.new(invoice_items, parent)

    assert_instance_of InvoiceItemRepository, ir
  end

  def test_it_can_find_all_invoice_items
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
    ir = InvoiceItemRepository.new(invoice_items, parent)
    assert_equal 2, ir.all.count
  end

  def test_it_can_find_invoice_items_by_id
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
    ir = InvoiceItemRepository.new(invoice_items, parent)
    assert_equal 3, ir.find_by_id("3").id
    assert_equal 4, ir.find_by_id("4").id
  end

  def test_it_can_find_invoice_items_by_item_id
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
    ir = InvoiceItemRepository.new(invoice_items, parent)
    assert_equal 223454178, ir.find_all_by_item_id("223454178")[0].item_id
    assert_equal 22454278, ir.find_all_by_item_id("22454278")[0].item_id
  end

  def test_it_can_find_invoice_items_by_invoice_id

    assert_equal 7, ir.find_by_id("7").id
    assert_equal 2, ir.find_by_id("2").id
  end
end
