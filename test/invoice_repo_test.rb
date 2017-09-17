require_relative 'test_helper'
require_relative '../lib/invoice_repo'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repo

  def set_up
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv"})
    SalesEngine.from_csv(files).invoices
  end

  def test_invoices_exists
    assert_instance_of Invoices, set_up
  end

end
