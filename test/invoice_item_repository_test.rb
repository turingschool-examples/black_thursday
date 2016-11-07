require_relative 'test_helper'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  # def setup
  #   se = SalesEngine.from_csv({
  #     :items => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #     :invoices => "./data/invoices.csv",
  #     :invoice_items => "./fixtures/invoice_item_small_list.csv",
  #     :transactions => "./data/transactions.csv",
  #     :customers => "./data/customers.csv"
  #   })
  # end

  def test_it_can_hold_invoice_items
    ir = InvoiceItemRepository.new
    ir.from_csv("./fixtures/invoice_item_small_list.csv")
    invoice = ir.find_by_id(6)
  
    assert_equal InvoiceItem, invoice.class
  end

  def test_it_can_find_by_item_id
    ir = InvoiceItemRepository.new
    ir.from_csv("./fixtures/invoice_item_small_list.csv")
    result = ir.find_all_by_item_id(263454779)

    assert_equal InvoiceItem, result[0].class
    assert_equal Array, result.class
  end

  def test_it_can_find_by_invoice_id
    ir = InvoiceItemRepository.new
    ir.from_csv("./fixtures/invoice_item_small_list.csv")
    result = ir.find_all_by_item_id(263451719)

    assert_equal InvoiceItem, result[0].class
    assert_equal Array, result.class
  end

end