require_relative './test_helper'
require './lib/invoice_item_repository'
require './lib/invoice_item'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @invoice_items =
      [{  id: 1,
          item_id: 263519841,
          invoice_id: 1,
          quantity: 5,
          unit_price: 13635,
          created_at: '2001-01-01 14:54:09 UTC',
          updated_at: '2011-01-01 14:54:09 UTC' },
       {  id: 2,
          item_id: 263519842,
          invoice_id: 2,
          quantity: 2,
          unit_price: 23635,
          created_at: '2002-02-02 14:54:09 UTC',
          updated_at: '2012-02-02 14:54:09 UTC' },
       {  id: 3,
          item_id: 263519843,
          invoice_id: 3,
          quantity: 3,
          unit_price: 33635,
          created_at: '2003-03-03 14:54:09 UTC',
          updated_at: '2013-03-03 14:54:09 UTC' }]
    @iir = InvoiceItemRepository.new(@invoice_items)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_it_can_build_invoice
    assert_equal Array, @iir.build_invoice(@invoice_items).class
  end

  def test_it_can_return_an_array_of_all_known_invoice_item_instances
    assert_equal 3, @iir.all.count
  end

  def test_it_can_find_an_invoice_item_by_a_valid_id
    item_invoice = @iir.find_by_id(1)
    assert_instance_of InvoiceItem, item_invoice
    assert_equal 1, item_invoice.id
  end

  def test_it_returns_nil_if_invoice_id_is_invalid
    invoice = @iir.find_by_id('invalid')
    assert_nil invoice
  end

  def test_it_can_find_all_by_item_id
    invoice_item_one = @iir.find_all_by_item_id(263519841)
    invoice_item_two = @iir.find_all_by_item_id(263519842)
    invoice_item_three = @iir.find_all_by_item_id(263519847)
    assert_equal 263519841, invoice_item_one.first.item_id
    assert_equal 263519842, invoice_item_two.first.item_id
    assert_equal 263519842, invoice_item_two[-1].item_id
    assert_equal [], invoice_item_three
  end

  def test_it_can_find_all_invoice_items_by_invoice_id
    invoice_items_one = @iir.find_all_by_invoice_id(1)
    invoice_items_two = @iir.find_all_by_invoice_id(2)
    invoice_items_three = @iir.find_all_by_invoice_id(5)
    assert_equal 1, invoice_items_one.first.invoice_id
    assert_equal 2, invoice_items_two.first.invoice_id
    assert_equal 2, invoice_items_two[-1].invoice_id
    assert_equal [], invoice_items_three
  end

  def test_it_can_create_new_id
    invoice_item = @iir.create_id
    assert_equal 4, invoice_item
  end

  def test_it_can_create_new_invoice_item
    attributes = {  item_id: 27,
                    invoice_id: 2772,
                    quantity: 4,
                    unit_price: 2134,
                    created_at: '2018-07-28',
                    updated_at: '2018-07-28'
                  }
    invoice_item = @iir.create(attributes)
    assert_equal 4, invoice_item.id
    assert_equal 27, invoice_item.item_id
    assert_equal 2772, invoice_item.invoice_id
    assert_equal 4, invoice_item.quantity
    assert_equal BigDecimal, invoice_item.unit_price.class
    assert_instance_of Time, invoice_item.created_at
    assert_instance_of Time, invoice_item.updated_at
  end

  def test_it_can_update_invoice_item
    attributes = {
      quantity: 4,
      unit_price: 15635
    }
    id = 1
    invoice_item = @iir.update(id, attributes)
    expected = @iir.find_by_id(id)
    assert_instance_of Time, invoice_item.updated_at # maybe refactor later
    assert_equal 1, expected.invoice_id
    assert_equal 4, expected.quantity
    assert_equal 15635, expected.unit_price
  end

  def test_it_can_delete_invoice
    id = 2

    invoice = @iir.delete(id)
    expected = @iir.find_by_id(2)

    assert_nil expected
  end
end
