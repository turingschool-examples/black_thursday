require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
require 'simplecov'

class InvoiceTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:invoices => './test/fixtures/invoice_one.csv'})
    inr = se.invoices
    i = inr.all

    assert_instance_of Invoice, i.first
  end

end
