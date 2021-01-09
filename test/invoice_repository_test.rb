require_relative 'test_helper'
require './invoice'
require './invoice_repository'
class InvoiceRepositoryTest < MiniTest::Test
  def setup
    merchant_path = "./data/merchants.csv"
    arguments = merchant_path
    #parent = mock("parent")
    @engine = SalesEngine.from_csv(arguments)
  end

  def test_it_exists
    invoice_id = 3452
    expected = @engine.invoices.find_by_id(invoice_id)
    assert_equal invoice_id, @expected.id
    assert_equal 12335690, @expected.merchant_id
    assert_equal 679, @expected.customer_id
    assert_equal :pending, @expected.status
    invoice_id = 5000
    expected = @engine.invoices.find_by_id(invoice_id)
    assert_nil expected
  end
