require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

# Test InvoiceItemRepository
class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @inv_itr = InvoiceItemRepository.new
  end

  def test_it_exists
    @inv_itr = InvoiceItemRepository.new
    assert_instance_of InvoiceItemRepository, @inv_itr
  end

  def test_it_can_create_invoice_items_from_csv
    @inv_itr.from_csv('./test/fixtures/invoice_items_fixtures.csv')
    assert_equal 50, @inv_itr.elements.count
    assert_instance_of InvoiceItem, @inv_itr.elements[32]
    assert_equal 6, @inv_itr.elements[32].invoice_id
    assert_instance_of InvoiceItem, @inv_itr.elements[14]
    assert_equal 7, @inv_itr.elements[14].quantity
    assert_equal 664.12, @inv_itr.elements[23].unit_price

    assert_nil @inv_itr.elements['id']
    assert_nil @inv_itr.elements[999999999]
    assert_nil @inv_itr.elements[0]
    assert_instance_of Time, @inv_itr.elements[34].created_at
    assert_instance_of Time, @inv_itr.elements[9].updated_at
  end

  def test_all_method
    @inv_itr.from_csv('./test/fixtures/invoice_items_fixtures.csv')
    all_invoices = @inv_itr.all
    assert_equal 50, all_invoices.count
    assert_instance_of InvoiceItem, all_invoices[0]
    assert_instance_of InvoiceItem, all_invoices[20]
    assert_instance_of InvoiceItem, all_invoices[-1]
    assert_instance_of Array, all_invoices
  end

  def test_find_by_id
    @inv_itr.from_csv('./test/fixtures/invoice_items_fixtures.csv')
    invoice_item = @inv_itr.find_by_id(37)
    assert_instance_of InvoiceItem, invoice_item
    assert_equal 7, invoice_item.invoice_id

    invoice2 = @inv_itr.find_by_id(14)
    assert_instance_of InvoiceItem, invoice2
    assert_equal 7, invoice2.quantity
    assert_nil @inv_itr.find_by_id(12345678901234567890)
  end

  def test_find_all_by_item_id
    @inv_itr.from_csv('./test/fixtures/invoice_items_fixtures.csv')
    invoices = @inv_itr.find_all_by_item_id(263515158)
    assert_instance_of Array, invoices
    assert_instance_of InvoiceItem, invoices[0]
    find = @inv_itr.find_by_id(5)
    assert invoices.include?(find)
    assert_equal 1, invoices.count

    invoices2 = @inv_itr.find_all_by_item_id(263533436)
    assert_instance_of Array, invoices2
    find = @inv_itr.find_by_id(32)
    find2 = @inv_itr.find_by_id(33)
    find3 = @inv_itr.find_by_id(34)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @inv_itr.find_all_by_item_id(9999999999)
    assert_equal [], invoices3
  end

  def test_find_all_by_invoice_id
    @inv_itr.from_csv('./test/fixtures/invoice_items_fixtures.csv')
    invoices = @inv_itr.find_all_by_invoice_id(2)
    assert_instance_of Array, invoices
    assert_instance_of InvoiceItem, invoices[0]
    find = @inv_itr.find_by_id(12)
    assert invoices.include?(find)
    assert_equal 4, invoices.count

    invoices2 = @inv_itr.find_all_by_invoice_id(8)
    assert_instance_of Array, invoices2
    find = @inv_itr.find_by_id(38)
    find2 = @inv_itr.find_by_id(40)
    find3 = @inv_itr.find_by_id(47)
    assert invoices2.include?(find)
    assert invoices2.include?(find2)
    refute invoices2.include?(find3)

    invoices3 = @inv_itr.find_all_by_invoice_id(9999999999)
    assert_equal [], invoices3
  end

  def test_it_can_create_a_new_invoice
    assert_equal 0, @inv_itr.all.count
    time = Time.now
    @inv_itr.create(
      item_id:    7,
      invoice_id: 8,
      quantity:   4,
      unit_price: BigDecimal.new(1099),
      created_at: time,
      updated_at: time
      )
    assert_equal 1, @inv_itr.all.count
    assert_equal time, @inv_itr.find_by_id(1).updated_at

    @inv_itr.create(
      item_id:    9,
      invoice_id: 12,
      quantity:   2,
      unit_price: BigDecimal.new(1599),
      created_at: time,
      updated_at: time
      )
    assert_equal 2, @inv_itr.all.count
    assert_equal 12, @inv_itr.find_by_id(2).invoice_id
  end

  def test_it_can_update_an_existing_invoice
    assert_equal 0, @inv_itr.all.count
    time = Time.now - 1
    @inv_itr.create(
      item_id:    7,
      invoice_id: 8,
      quantity:   4,
      unit_price: BigDecimal.new(1099),
      created_at: @time,
      updated_at: @time
                )
    assert_equal 1, @inv_itr.all.count
    assert_equal 8, @inv_itr.find_by_id(1).invoice_id

    @inv_itr.update(1, {
      item_id:    8,
      invoice_id: 10,
      quantity:   3,
      unit_price: BigDecimal.new(1499),
      created_at: @time,
      updated_at: @time
                    })
    assert_equal 1, @inv_itr.all.count
    assert_equal 10, @inv_itr.find_by_id(1).invoice_id
    assert_equal 8, @inv_itr.find_by_id(1).item_id
    assert_equal 3, @inv_itr.find_by_id(1).quantity
    assert time < @inv_itr.find_by_id(1).updated_at
  end

  def test_it_can_delete_an_existing_invoice
    assert_equal 0, @inv_itr.all.count
    time = Time.now
    @inv_itr.create(
      item_id:    7,
      invoice_id: 8,
      quantity:   4,
      unit_price: BigDecimal.new(1099),
      created_at: time,
      updated_at: time
                )
    assert_equal 1, @inv_itr.all.count
    assert_equal 8, @inv_itr.find_by_id(1).invoice_id

    @inv_itr.delete(1)
    assert_equal 0, @inv_itr.all.count
  end
end
