require './lib/invoice_repository'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
    invoice = se.invoices.find_by_id(6)
  end


end
