require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repository'
require 'simplecov'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    sa = SalesEngine.from_csv({:invoices => './test/fixtures/invoice_one.csv'})
    inr = sa.invoices

    assert_instance_of InvoiceRepository, inr
  end

  

end
