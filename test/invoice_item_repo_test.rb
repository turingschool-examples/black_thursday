require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/invoice_item_repo'
require './lib/invoice_item'
require './lib/invoice'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repo'
require './lib/item'
require './lib/item_repo'

class InvoiceItemRepoTest < MiniTest::Test
  def setup
    @se = SalesEngine.from_csv({
                                :invoice_items => './data/invoice_items.csv'
                                })
    @invoice_item = @se.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepo, @invoice_item
  end

  def test_invoice_item_repo_can_find_all
    expected = @invoice_item.all

    assert_equal 21830, expected.count
  end

  def test_it_can_find_invoice_item_by_id
    expected = @invoice_item.find_by_id(10)
    no_result = @invoice_item.find_by_id(200000)

    assert_equal 263523644, expected.item_id
    assert_equal 2, expected.invoice_id
    assert_nil no_result
  end

  def test_it_can_find_all_items_by_item_id
    expected = @invoice_item.find_all_by_item_id(263408101)

    assert_equal 11, expected.length
  end

  def test_it_returns_an_empty_array_for_item_id_matches
    expected = @invoice_item.find_all_by_item_id(10)

    assert_equal 0, expected.length
    assert_equal ([]), expected
  end

  def test_find_all_by_invoice_id
    expected = @invoice_item.find_all_by_invoice_id(100)

    assert_equal 3, expected.length
  end

  def test_it_finds_all_by_invoice_id
    expected = @invoice_item.find_all_by_invoice_id(1234567890)

    assert_equal 0, expected.length
    assert_equal ([]), expected
  end

  def test_it_can_create_a_new_invoice_item_instance
    attributes = {
                  :item_id => 7,
                  :invoice_id => 8,
                  :quantity => 1,
                  :unit_price => BigDecimal.new(10.99, 4),
                  :created_at => Time.now,
                  :updated_at => Time.now
                }
    @se.invoice_items.create(attributes)
    expected = @se.invoice_items.find_by_id(21831)
    assert_equal 7, expected.item_id
  end

  def test_it_can_update_a_new_invoice_item_instance
    attributes = {
                  :quantity => 13,
                 }

    @se.invoice_items.update(21830, attributes)
    expected = @se.invoice_items.find_by_id(21830)

    assert_equal 13, expected.quantity
  end

  def test_it_can_delete_an_invoice
    @invoice_item.delete(4986)
    expected = @invoice_item.find_by_id(4986)

    assert_nil expected
  end
end
