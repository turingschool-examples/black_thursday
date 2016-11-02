require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({
      :invoices => "./data_fixtures/invoices_fixture.csv"
    })
  end

  def test_invoice_repo_exists
    assert sales_engine.invoices
  end

  def test_all_returns_an_array
    invoice_repository = sales_engine.invoices
    assert_kind_of Array, invoice_repository.all
  end

  # def test_all_returns_an_array_of_all_invoice_objects

  # end

  def inspect
  end

end
