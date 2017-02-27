require './test/test_helper'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :invoices => "./data/invoices.csv",
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    @ir = @se.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @ir
  end

end
