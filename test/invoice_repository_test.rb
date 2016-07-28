require './test/test_helper'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_creates_an_array
    se = SalesEngine.from_csv({invoices:  "./data/invoices_sample.csv"})
    iv = se.invoices
    assert_equal true, iv.all.is_a?(Array)
  end

  def test_it_populates_the_correct_number_of_invoices
    se = SalesEngine.from_csv({invoices:  "./data/invoices_sample.csv"})
    iv = se.invoices
    assert_equal 100, iv.all.length
  end

  
end
