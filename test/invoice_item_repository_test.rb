require_relative 'test_helper'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_fixture.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices => './test/fixtures/invoices.csv',
      :invoice_items => './test/fixtures/invoice_items.csv'})
    @invoice_items = @sales_engine.invoice_items
  end

  def test_that_invoice_item_returns_all
    assert_equal @invoice_items.invoice_items, @invoice_items.all
  end

end
