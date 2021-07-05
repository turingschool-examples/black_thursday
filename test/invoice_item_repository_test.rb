require_relative 'test_helper'
require './lib/invoice_item_repository'

class TestInvoiceItemRepository < Minitest::Test
  def setup
    @loaded_file = [{id: 1, item_id: 1, invoice_id: 1 , quantity: 1, unit_price: 13635, created_at: '2012-03-23 12:54:09 UTC', updated_at: '2013-03-27 14:54:09 UTC'},
                    {id: 2, item_id: 1, invoice_id: 1, quantity: 3, unit_price: 12144, created_at: '2010-03-07 11:54:09 UTC', updated_at: '2011-03-27 14:54:09 UTC'},
                    {id: 3, item_id: 1, invoice_id: 2, quantity: 8, unit_price: 12345, created_at: '2011-03-17 05:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC'},
                    {id: 4, item_id: 2, invoice_id: 3, quantity: 5, unit_price: 1000, created_at: '2010-03-12 06:54:09 UTC', updated_at: '2013-03-27 14:54:09 UTC'},
                    {id: 5, item_id: 3, invoice_id: 4, quantity: 5, unit_price: 74444, created_at: '2011-03-11 07:54:09 UTC', updated_at: '2014-03-27 14:54:09 UTC'},
                    {id: 6, item_id: 3, invoice_id: 4, quantity: 3, unit_price: 89999, created_at: '2009-03-10 03:54:09 UTC', updated_at: '2010-03-27 14:54:09 UTC'},
                    {id: 7, item_id: 4, invoice_id: 5, quantity: 8, unit_price: 9990, created_at: '2008-03-09 02:54:09 UTC', updated_at: '2010-03-27 14:54:09 UTC'},
                    {id: 8, item_id: 5, invoice_id: 6, quantity: 2, unit_price: 1360, created_at: '2005-04-27 11:54:09 UTC', updated_at: '2007-03-27 14:54:09 UTC'},
                    {id: 9, item_id: 6, invoice_id: 7, quantity: 1, unit_price: 10000, created_at: '2005-05-27 12:54:09 UTC', updated_at: '2008-03-27 14:54:09 UTC'},
                    {id: 10, item_id: 6, invoice_id: 7, quantity: 7, unit_price: 11245, created_at: '2002-06-27 07:54:09 UTC', updated_at: '2004-03-27 14:54:09 UTC'},
                    {id: 11, item_id: 6, invoice_id: 7, quantity: 9, unit_price: 1363, created_at: '2007-01-27 11:54:09 UTC', updated_at: '2010-03-27 14:54:09 UTC'},
                    {id: 12, item_id: 7, invoice_id: 8, quantity: 10, unit_price: 1335, created_at: '2013-02-27 02:54:09 UTC', updated_at: '2014-03-27 14:54:09 UTC'},
                    {id: 13, item_id: 8, invoice_id: 9, quantity: 13, unit_price: 1635, created_at: '2015-11-27 03:54:09 UTC', updated_at: '2016-03-27 14:54:09 UTC'},
                    {id: 14, item_id: 9, invoice_id: 10, quantity: 12, unit_price: 3635, created_at: '2013-05-27 04:54:09 UTC', updated_at: '2015-03-27 14:54:09 UTC'},
                    {id: 15, item_id: 10, invoice_id: 10, quantity: 11, unit_price: 1363, created_at: '2011-10-27 05:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC'},
                    {id: 16, item_id: 10, invoice_id: 11, quantity: 4, unit_price: 1335, created_at: '2010-06-27 06:54:09 UTC', updated_at: '2015-03-27 14:54:09 UTC'},
                    {id: 17, item_id: 11, invoice_id: 12, quantity: 1, unit_price: 33635, created_at: '2013-02-27 07:54:09 UTC', updated_at: '2014-03-27 14:54:09 UTC'},
                    {id: 18, item_id: 12, invoice_id: 12, quantity: 4, unit_price: 53635, created_at: '2015-02-27 08:54:09 UTC', updated_at: '2016-03-27 14:54:09 UTC'},
                    {id: 19, item_id: 12, invoice_id: 13, quantity: 5, unit_price: 13635, created_at: '2012-09-27 09:54:09 UTC', updated_at: '2013-03-27 14:54:09 UTC'},
                    {id: 20, item_id: 12, invoice_id: 14, quantity: 6, unit_price: 6353, created_at: '2002-12-27 04:54:09 UTC', updated_at: '2004-03-27 14:54:09 UTC'}]
    @iir = InvoiceItemRepository.new(@loaded_file)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_all_returns_repository_of_invoice_items
    assert_equal 20, @iir.all.count
    assert_equal InvoiceItem, @iir.all.first.class
  end

  def test_it_finds_an_invoice_item_by_id
      invoice_item = @iir.find_by_id(10)

      assert_equal 10, invoice_item.id
      assert_equal 6, invoice_item.item_id
      assert_equal 7, invoice_item.invoice_id
  end

  def test_it_finds_all_items_matching_given_item_id
      item_ids = @iir.find_all_by_item_id(1)

      assert_equal 3, item_ids.length
      assert_equal InvoiceItem, item_ids.first.class
  end

  def test_if_finds_all_items_matching_given_item_id
      invoice_items = @iir.find_all_by_invoice_id(10)

      assert_equal 2, invoice_items.length
      assert_equal InvoiceItem, invoice_items.first.class
  end

  def test_it_creates_a_new_invoice_item_instance
    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }

    @iir.create(attributes)
    invoice_item = @iir.find_by_id(21)
    assert_equal 7, invoice_item.item_id
  end

  def test_it_updates_an_invoice_item
      original_time = @iir.find_by_id(5).updated_at

      attributes = {quantity: 14,
                    unit_price: BigDecimal.new(11.11, 4)
                  }
      @iir.update(5, attributes)

      invoice_item = @iir.find_by_id(5)
      assert_equal 14, invoice_item.quantity
      assert_equal 11.11, invoice_item.unit_price
      assert_equal 3, invoice_item.item_id
      assert invoice_item.updated_at > original_time
  end

  def test_it_can_delete_the_specified_invoice
      @iir.delete(13)
      assert_nil @iir.find_by_id(13)
  end

end
