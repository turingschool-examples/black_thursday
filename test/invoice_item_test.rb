require_relative 'test_helper'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'



class InvoiceItemTest < Minitest::Test

  attr_reader :se, :invoice_item

  def setup
    @se = SalesEngine.from_csv({
      :invoice_items     => "./data/small_invoice_items.csv",
      :items => "./data/items.csv",})
    @se.invoice_items
    @se.items
    @invoice_item = @se.invoice_items.all[6]
  end



end
