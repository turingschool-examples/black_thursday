require_relative 'test_helper'
require_relative './lib/sales_engine'
require_relative './lib/invoice_repository'
require 'pry'

class InvoiceRepositoryTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({:items => './test/fixtures/items_fixture.csv',
    :merchants => './test/fixtures/merchants.csv',
    :invoices => './test/fixtures/invoices.csv'})
    @invoices = @sales_engine.invoices
  end

  def test_that_invoices_are_created
    assert_equal 19, @invoices.count
    assert_equal 1, @invoices.invoices[0].id
    assert_equal 2, @invoices.invoices[1].id
  end

  def test_that_it_finds_all_invoices
    assert_equal @invoices.invoices, @invoices.all
  end

  def test_that_it_finds_invoices_by_id
    invoice1 = @invoices.invoices[0]

    assert_equal invoice1, @invoices.find_by_id(1)
  end

  def test_that_it_finds_all_by_customer_id
    invoice1 = @invoices.invoices[12]
    invoice2 = @invoices.invoices[13]
    invoice3 = @invoices.invoices[14]

    assert_equal ([]), @invoices.find_all_by_customer_id(100)
    assert_equal [invoice1, invoice2, invoice3], @invoices.find_all_by_customer_id(3)
  end

  def test_that_it_finds_all_by_merchant_id
    invoice1 = @invoices.invoices[0]
    invoice2 = @invoices.invoices[1]

    assert_equal ([]), @invoices.find_all_by_merchant_id(100)
    assert_equal [invoice1, invoice2], @invoices.find_all_by_merchant_id(12334112)
  end

  def test_that_it_finds_all_by_status
    invoice1 = @invoices.invoices[0]
    invoice2 = @invoices.invoices[3]
    invoice3 = @invoices.invoices[4]
    invoice4 = @invoices.invoices[5]
    invoice5 = @invoices.invoices[6]
    invoice6 = @invoices.invoices[9]
    invoice7 = @invoices.invoices[10]
    invoice8 = @invoices.invoices[13]
    invoice9 = @invoices.invoices[16]
    result = [invoice1, invoice2, invoice3, invoice4, invoice5, invoice6, invoice7, invoice8, invoice9]

    assert_equal ([]), @invoices.find_all_by_status("return")
    assert_equal result, @invoices.find_all_by_status("pending")
  end

end
