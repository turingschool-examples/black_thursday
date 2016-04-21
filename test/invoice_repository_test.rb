require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :se, :item_repo
  def setup
    @se = SalesEngine.from_csv({
      :invoice => "./data/small_invoices.csv" })
    @item_repo = se.items
  end



end
