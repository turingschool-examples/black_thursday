require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repo'

class InvoiceItemRepositoryTest < Minitest::Test

  def set_up
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv", :items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv", :invoice_items => "./test/fixtures/invoice_items_fixture.csv", :transactions => "./test/fixtures/transactions_fixture.csv", :customers => "./test/fixtures/customers_fixture.csv"})
    SalesEngine.from_csv(files).invoice_items
  end

  def test_item_exists
    assert_instance_of InvoiceItem, set_up
  end

  

end
