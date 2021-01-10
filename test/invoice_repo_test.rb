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
                              :items => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"
                              })
    @invoices = @se.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepo, @invoices
  end
  #
  def test_item_repo_can_find_all
    skip
    expected = @se.invoices.all
    assert_equal 4958, expected
  end
  #
  def test_item_repo_can_find_by_id
    skip
    expected = @se.invoices.find_by_id(3452)
    assert_equal 12335690, expected.merchant_id
  end
  #
  def test_find_all_by_customer_id
    skip
    expected = @se.invoices.find_all_by_customer_id(300)
    assert_equal 10, expected.length
    results = @se.invoices.find_all_by_customer_id(1000)
    assert_equal ([]), results
  end

  def test_find_all_by_merchant_id
    skip
    expected = @se.invoices.find_all_by_merchant_id(12335080)
    assert_equal 7, expected.length
  end

  def test_find_all_by_status
    skip
    expected = @se.invoices.find_all_by_status(:shipped)
    assert_equal 2839, expected.length
  end

  def test_create_a_new_invoice_instance
    skip
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
    original = @se.invoices.find_by_id(4986)
    attributes = {status: :success}
    @se.invoices.update(4986, attributes)
    assert_equal :success, expected.status
  end

  def test_delete_an_invoice
    skip
    @se.invoices.delete(4986)
    expected = @se.invoices.find_by_id(4986)
    assert_equal nil, expected
  end
end
