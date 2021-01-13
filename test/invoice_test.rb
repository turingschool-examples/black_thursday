require_relative 'test_helper'

class InvoiceTest < MiniTest::Test
  def setup
    item_path = "./data/items.csv"
    merchant_path = "./data/merchants.csv"
    invoice_path = "./data/invoices.csv"
    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path
                }
    @engine = SalesEngine.from_csv(arguments)
    @invoice = @engine.invoices.find_by_id(3452)
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_id_returns_invoice_id

    assert_equal Integer, @invoice.id.class
  end

  def test_customer_id_returns_the_invoice_customer_id
    assert_equal 679, @invoice.customer_id

    assert_equal Integer, @invoice.customer_id.class
  end

  def test_merchant_id_returns_the_invoice_merchant_id
    assert_equal 12335690, @invoice.merchant_id

    assert_equal Integer, @invoice.merchant_id.class
  end

  def test_status_returns_the_invoice_status
    assert_equal :pending, @invoice.status
    assert_equal Symbol, @invoice.status.class
  end

  def test_created_at_returns_the_time_instance_for_the_date_the_invoice_wasa_created
    assert_equal Time.parse("2015-07-10 00:00:00 -0600"), @invoice.created_at
     assert_equal Time, @invoice.created_at.class
  end

  def test_updated_at_returns_the_time_instance_for_the_date_the_invoice_wasa_updated
    assert_equal Time.parse("2015-12-10 00:00:00 -0700"), @invoice.updated_at
    assert_equal Time, @invoice.updated_at.class
  end
end
