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

  def test_that_it_can_find_an_invoice_by_its_id
    se = SalesEngine.from_csv({invoices:  "./data/invoices_sample.csv"})
    iv = se.invoices
    assert_equal "shipped", iv.find_by_id(2).status
  end

  def test_that_it_returns_nil_for_invalid_id
    se = SalesEngine.from_csv({invoices:  "./data/invoices_sample.csv"})
    iv = se.invoices
    assert_equal nil, iv.find_by_id(99999)
  end

  def test_that_find_all_by_customer_id_returns_an_array
    se = SalesEngine.from_csv({invoices:  "./data/invoices_sample.csv"})
    iv = se.invoices
    assert_equal [], iv.find_all_by_customer_id(99999)
  end

  def test_that_find_all_by_customer_id_returns_an_array_of_proper_length
    se = SalesEngine.from_csv({invoices:  "./data/invoices_sample.csv"})
    iv = se.invoices
    assert_equal 4, iv.find_all_by_customer_id(2).length
  end

  def test_that_find_all_by_merchant_id_returns_an_array
    se = SalesEngine.from_csv({invoices:  "./data/invoices_sample.csv"})
    iv = se.invoices
    assert_equal [], iv.find_all_by_merchant_id(77777777)
  end

  def test_that_find_all_by_merchant_id_returns_an_array_of_proper_length
    se = SalesEngine.from_csv({invoices:  "./data/invoices_sample.csv"})
    iv = se.invoices
    assert_equal 2, iv.find_all_by_merchant_id(12334771).length
  end

  def test_that_find_all_by_status_returns_an_array
    se = SalesEngine.from_csv({invoices:  "./data/invoices_sample.csv"})
    iv = se.invoices
    assert_equal [], iv.find_all_by_status("backordered")
  end

  def test_that_find_all_by_status_returns_an_array_of_proper_length
    se = SalesEngine.from_csv({invoices:  "./data/invoices_sample.csv"})
    iv = se.invoices
    assert_equal 29, iv.find_all_by_status("pending").length
  end


end
