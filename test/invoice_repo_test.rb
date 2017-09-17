require_relative 'test_helper'
require_relative '../lib/invoice_repo'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repo

  def set_up
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv", :items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv"})
    SalesEngine.from_csv(files).invoices
  end

  def test_invoices_exists
    assert_instance_of InvoiceRepository, set_up
  end

  def test_all_invoices
    assert_equal 10, set_up.all.count
  end

  def test_find_by_id
    assert_nil set_up.find_by_id(293480)
  end

  def test_find_specific_invoice_id
    assert_instance_of Invoice, set_up.find_by_id(5)
  end

end
