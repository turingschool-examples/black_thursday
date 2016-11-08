require_relative 'test_helper'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items => "./fixtures/items_small_list.csv",
      :invoices => "./fixtures/invoices_small_list.csv",
      :merchants => "./fixtures/merchant_small_list.csv",
      :invoice_items => "./fixtures/invoice_item_small_list.csv",
      :transactions => "./fixtures/transactions_small_list.csv",
      :customers => "./fixtures/customers_small_list.csv"
    })
  end

  def test_it_can_hold_invoice_items
    result = @se.invoice_items.find_by_id(6)
  
    assert_equal InvoiceItem, result.class
  end

  def test_it_can_find_by_item_id
    result = @se.invoice_items.find_all_by_item_id(263454779)

    assert_equal InvoiceItem, result[0].class
    assert_equal Array, result.class
  end

  def test_it_can_find_by_invoice_id
    result = @se.invoice_items.find_all_by_item_id(263451719)

    assert_equal InvoiceItem, result[0].class
    assert_equal Array, result.class
  end

end