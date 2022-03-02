require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/invoice_repo'
require './lib/invoice'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repo'
require './lib/item'
require './lib/item_repo'

class InvoiceRepoTest < MiniTest::Test
  def setup
    @se = SalesEngine.from_csv({
                              :invoices => "./data/invoices.csv"
                              })
    # @invoices = @se.invoices
  end

  def test_it_exists
    @se = SalesEngine.from_csv({
                              :invoices => "./data/invoices.csv"
                              })

    assert_instance_of InvoiceRepo, @se.invoices
  end

  def test_item_repo_can_find_all
    expected = @se.invoices.all
    assert_equal 4985, expected.count
  end

  def test_item_repo_can_find_by_id
    expected = @se.invoices.find_by_id(3452)
    result = @se.invoices.find_by_id(00)
    assert_equal 12335690, expected.merchant_id
    assert_nil result
  end

  def test_find_all_by_customer_id
    expected = @se.invoices.find_all_by_customer_id(300)
    assert_equal 10, expected.length
    results = @se.invoices.find_all_by_customer_id(1000)
    assert_equal ([]), results
  end

  def test_find_all_by_merchant_id
    expected = @se.invoices.find_all_by_merchant_id(12335080)
    assert_equal 7, expected.length
  end

  def test_find_all_by_status
    expected = @se.invoices.find_all_by_status(:shipped)
    assert_equal 2839, expected.length
  end

  def test_create_a_new_invoice_instance
    attributes = {
                    :customer_id => 7,
                    :merchant_id => 8,
                    :status      => "pending",
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                  }
    @se.invoices.create(attributes)
    expected = @se.invoices.find_by_id(4986)
    assert_equal 8, expected.merchant_id
  end

  def test_update_an_invoice
    skip
    attributes = {status: :success,
                  updated_at: Time.now
                  }

    invoice = @se.invoices.find_by_id(6)
    @se.invoices.update(6, attributes)    # invoice.stubs(:update_time).returns("at 08:37 AM")
    assert_equal :success, invoice.status

    time1 = mock("time1")
    time1.stubs(:now).returns("at 08:37 AM")
    invoice.update_time(time1)
    assert_equal ("at 08:37 AM"), invoice.updated_at
  end

  def test_delete_an_invoice
    @se.invoices.delete(4986)
    expected = @se.invoices.find_by_id(4986)
    assert_nil expected
  end
end
