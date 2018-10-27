require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoiceTest < MiniTest::Test

  def setup
    @time = Time.now.to_s
    @invoice = Invoice.new({
                :id          => 1,
                :customer_id => 10,
                :merchant_id => 100,
                :status      => "pending",
                :created_at  => @time,
                :updated_at  => @time
              })
  end

  def test_invoice_exists

    assert_instance_of Invoice, @invoice
  end

  def test_it_has_id
    assert_equal 1, @invoice.id
  end

  def test_it_has_cust_id
    assert_equal 10, @invoice.customer_id
  end

  def test_it_has_merchant_id
    assert_equal 100, @invoice.merchant_id
  end

  def test_it_has_status
    assert_equal "pending", @invoice.status
  end

  def test_it_has_created_at
    assert_equal @time, @invoice.created_at
  end

  def test_it_has_updated_at
    assert_equal @time, @invoice.updated_at
  end
end
