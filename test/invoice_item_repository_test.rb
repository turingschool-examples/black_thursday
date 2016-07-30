require './test/test_helper'
require './lib/sales_engine'


class InvoiceItemRepositoryTest < Minitest::Test

  def test_that_it_creates_an_array
    se = SalesEngine.from_csv({ invoice_items: "./test/samples/invoice_items_sample.csv"})
    ii = se.invoice_items

    assert_equal true, ii.all.is_a?(Array)
  end

  def test_that_it_creates_an_array_of_proper_length
    se = SalesEngine.from_csv({ invoice_items: "./test/samples/invoice_items_sample.csv"})
    ii = se.invoice_items

    assert_equal 100, ii.all.length
  end

  def test_that_find_an_invoice_item_by_its_id
    se = SalesEngine.from_csv({ invoice_items: "./test/samples/invoice_items_sample.csv"})
    ii = se.invoice_items

    assert_equal 263519844, ii.find_by_id(1).item_id
  end

  def test_that_it_returns_nil_for_invalid_id
    se = SalesEngine.from_csv({ invoice_items: "./test/samples/invoice_items_sample.csv"})
    ii = se.invoice_items

    assert_equal nil, ii.find_by_id(999999)
  end

  def test_find_all_by_item_id_returns_an_array
    se = SalesEngine.from_csv({ invoice_items: "./test/samples/invoice_items_sample.csv"})
    ii = se.invoice_items

    assert_equal [], ii.find_all_by_item_id(999999)
  end

  def test_find_all_by_item_id_returns_an_array_of_proper_length
    se = SalesEngine.from_csv({ invoice_items: "./test/samples/invoice_items_sample.csv"})
    ii = se.invoice_items

    assert_equal 2, ii.find_all_by_item_id(263529264).length
  end

  def test_find_all_by_invoice_id_returns_an_array
    se = SalesEngine.from_csv({ invoice_items: "./test/samples/invoice_items_sample.csv"})
    ii = se.invoice_items

    assert_equal [], ii.find_all_by_invoice_id(999999999)
  end

  def test_find_all_by_invoice_id_returns_an_array_of_proper_length
    se = SalesEngine.from_csv({ invoice_items: "./test/samples/invoice_items_sample.csv"})
    ii = se.invoice_items

    assert_equal 8, ii.find_all_by_invoice_id(1).length
  end

end
