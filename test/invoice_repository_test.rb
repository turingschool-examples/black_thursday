require_relative 'test_helper'
require_relative  '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices => "./test/fixtures/invoice_fixture.csv"
    })
    vr = se.invoices
  end

  def test_invoice_repo_returns_array_of_all_invoices
    vr = setup

    assert_equal ,vr.all
  end 

  def test_it_finds_invoice_by_id
    vr = setup

    assert_equal ,vr.find_by_id()
  end 

end 