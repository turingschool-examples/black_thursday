require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repo'

class InvoiceItemRepositoryTest < Minitest::Test

  def set_up
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv", :items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv", :invoice_items => "./test/fixtures/invoice_items_fixture.csv", :transactions => "./test/fixtures/transactions_fixture.csv", :customers => "./test/fixtures/customers_fixture.csv"})
    SalesEngine.from_csv(files).invoice_items
  end

  def test_invoice_item_exists
    assert_instance_of InvoiceItemRepository, set_up
  end

  def test_find_by_id
    assert_instance_of InvoiceItem, set_up.find_by_id(6)
  end

  def test_find_by_item_id
    assert_instance_of InvoiceItem, set_up.find_all_by_item_id(263539664).first
  end

  def test_find_by_invoice_id
    assert_instance_of InvoiceItem, set_up.find_all_by_invoice_id(1).first
  end
end
