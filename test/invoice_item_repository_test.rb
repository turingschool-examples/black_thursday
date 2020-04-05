require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_fixture.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices => './test/fixtures/invoices.csv',
      :invoice_items => './test/fixtures/invoice_items.csv',
      :transactions => './test/fixtures/transactions.csv',
      :customers => './test/fixtures/customers.csv'})
    @invoice_items = @sales_engine.invoice_items
  end

  def test_that_invoice_item_returns_all
    assert_equal @invoice_items.invoice_items, @invoice_items.all
  end

  def test_that_it_finds_all_invoice_items_by_item_id
    invoice_item_1 = @invoice_items.all[2]
    invoice_item_2 = @invoice_items.all[3]

    assert_equal [], @invoice_items.find_all_by_item_id(238409283)
    assert_equal [invoice_item_1, invoice_item_2],
                  @invoice_items.find_all_by_item_id(263401607)
  end

  def test_that_it_finds_all_invoice_items_by_invoice_id
    invoice_item_1 = @invoice_items.all[0]
    invoice_item_2 = @invoice_items.all[1]
    invoice_item_3 = @invoice_items.all[2]
    invoice_item_4 = @invoice_items.all[3]
    invoice_item_5 = @invoice_items.all[4]
    invoice_item_6 = @invoice_items.all[5]
    invoice_item_7 = @invoice_items.all[6]
    invoice_item_8 = @invoice_items.all[7]

    assert_equal [], @invoice_items.find_all_by_invoice_id(1209)
    assert_equal [invoice_item_1, invoice_item_2, invoice_item_3,
                  invoice_item_4, invoice_item_5, invoice_item_6,
                  invoice_item_7, invoice_item_8],
                  @invoice_items.find_all_by_invoice_id(1)
  end

end
