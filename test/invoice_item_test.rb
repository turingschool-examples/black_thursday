require_relative 'test_helper'
require 'pry'


class InvoiceItemTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_fixture.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices => './test/fixtures/invoices.csv',
      :invoice_items => './test/fixtures/invoice_items.csv'})
    @invoice_items = @sales_engine.invoice_items
  end


end
