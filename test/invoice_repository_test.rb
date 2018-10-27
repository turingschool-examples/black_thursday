require_relative './helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
class InvoiceRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
    @invoices = se.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoices
  end
end
