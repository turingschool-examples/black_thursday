require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/invoice_item_repo'
require './lib/invoice_repo'
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
    @invoice_items = @se.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepo, @invoice_items
  end

  def test_invoice_item_repo_can_find_all
    expected = @invoice_items.all

    assert_equal 21830, expected.count
  end

  def test_it_can_find_invoice_item_by_id
    expected = @invoice_items.find_by_id(10)
    no_result = @invoice_items.find_by_id(200000)

    assert_equal 263523644, expected.item_id
    assert_equal 2, expected.length
    assert_nil, no_result
  end

  def test_it_can_find_all_items_by_item_id
    expected = @invoice_items.find_all_by_item_id(263408101)
    no_result = @invoice_items.find_by_id(200000)

    assert_equal 11, expected.length
    assert_equal 263523644, expected.item_id
    assert_nil, no_result
  end

  def test_it_returns_an_empty_array_for_no_item_id_matches
    expected = @invoice_items.find_all_by_item_id(10)
    no_result = @invoice_items.find_by_id(200000)

    assert_equal 0, expected.length
    assert_equal ([]), no_result
  end

end
