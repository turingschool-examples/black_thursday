require './test_helper'
require './lib/invoice_item'
require './lib/invoice_item_repository'
require './lib/file_loader'
require './lib/sales_engine'
require 'bigdecimal'
require 'pry'

class InvoiceItemRepositoryTest < MiniTest::Test
  def setup
    se = SalesEngine.from_csv({
    :items => "./data/item_sample.csv",
    :merchants => "./data/merchant_sample.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })

    @iir = se.invoice_items
  end

  def test_it_returns_array_of_all_invoices
    assert_equal 21830, @iir.all.length
  end

  def test_find_invoice_item_by_id
    found_invoice_item = @iir.find_by_id(10)

    assert_equal 263523644, found_invoice_item.item_id
    assert_equal 2, found_invoice_item.invoice_id
  end

  def test_it_returns_nil_if_invoice_item_id_is_not_present
    assert_nil @iir.find_by_id(200000)
  end

  def test_it_can_find_all_by_item_id
    assert_equal 11, @iir.find_all_by_item_id(263408101).length
    assert_instance_of InvoiceItem, @iir.find_all_by_item_id(263408101).first
  end

  def test_it_returns_empty_array_if_item_id_is_nonexistan
    assert_equal [], @iir.find_all_by_item_id(10)
    assert @iir.find_all_by_item_id(10).empty?
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 3, @iir.find_all_by_invoice_id(100).length
    assert_instance_of InvoiceItem, @iir.find_all_by_invoice_id(100).first
  end

  def test_it_returns_empty_array_if_invoice_id_is_nonexistant
    assert_equal [], @iir.find_all_by_invoice_id(1234567890)
    assert @iir.find_all_by_invoice_id(1234567890).empty?
  end

  def test_it_can_create_new_invoice_item
    attributes = {:item_id => 7,
                  :invoice_id => 8,
                  :quantity => 1,
                  :unit_price => BigDecimal.new(10.99,4),
                  :created_at => Time.now,
                  :updated_at => Time.now}
    @iir.create(attributes)

    new_ivoice_item = @iir.find_by_id(21831)
    assert_equal 7, new_ivoice_item.item_id
  end

  
end
