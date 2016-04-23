require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test

  attr_reader :se, :invoice_item_repo

  def setup
    @se = SalesEngine.from_csv({
      :invoice_items => "./data/small_invoice_items.csv" })
    @invoice_item_repo = @se.invoice_items
  end

  def test_invoice_item_all_finds_all
    assert_equal 10, invoice_item_repo.all.length
  end

  def test_invoice_item_all_can_identify_invoice_item_object
    assert_equal 1, invoice_item_repo.all[0].id
  end

  def test_invoice_item_can_find_by_id
    assert_equal 263523644, invoice_item_repo.find_by_id(10).item_id
  end

  def test_invoice_item_finds_all_by_item_id
    assert_equal 2, invoice_item_repo.find_all_by_item_id(263519844).length
  end

  def test_we_can_identify_find_all_by_invoice_id
    assert_equal 8, invoice_item_repo.find_all_by_invoice_id(1).length
  end

end
