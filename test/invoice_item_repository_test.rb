require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exists
    ii = InvoiceItemRepository.new('./data/invoice_items.csv')

    assert_instance_of InvoiceItemRepository, ii
  end

  def test_it_holds_an_array_of_invoice_items
    ii = InvoiceItemRepository.new('./data/invoice_items.csv')

    assert_equal 21830, ii.all.count
    assert_instance_of InvoiceItem, ii.all[0]
  end

  def test_it_can_find_by_id
    ii = InvoiceItemRepository.new('./data/invoice_items.csv')

    assert_equal ii.all[0], ii.find_by_id(1)
    assert_nil ii.find_by_id("aaaa")
  end

  def test_it_can_find_all_by_item_id
    ii = InvoiceItemRepository.new('./data/invoice_items.csv')

    assert_equal 11, ii.find_all_by_item_id(263408101).count
    assert_equal [],  ii.find_all_by_item_id(11111111111111111)
  end

  def test_it_can_find_all_by_invoice_id
    ii = InvoiceItemRepository.new('./data/invoice_items.csv')

    assert_equal 3, ii.find_all_by_invoice_id(100).count
    assert_equal [], ii.find_all_by_invoice_id(10000000009000)
  end

  def test_it_can_create_a_new_invoice_item
    ii = InvoiceItemRepository.new('./data/invoice_items.csv')
    data ={
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now.to_s,
    :updated_at => Time.now.to_s
    }
    ii.create(data)
    actual = ii.find_by_id(21831)

    assert_equal ii.all.last , actual
  end

  def test_it_can_update_an_invoice_item
    ii = InvoiceItemRepository.new('./data/invoice_items.csv')
    attributes = {
      quantity: 13
      }
    ii.update(6, attributes)
    actual = ii.find_by_id(6).quantity
    assert_equal 13, actual
  end

  def test_it_can_delete_an_item_invoice
    ii = InvoiceItemRepository.new('./data/invoice_items.csv')
    ii.delete(1)

    assert_nil ii.find_by_id(1)
  end
end
