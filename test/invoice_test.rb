require_relative '../lib/invoice'
require_relative '../test/test_helper'

class InvoiceTest < Minitest::Test

  def setup
    @parent = mock("parent")
    @invoice = Invoice.new({
                            :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => "2009-02-07",
                            :updated_at  => "2014-03-15" },
                            @parent)

  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_id
    assert_equal 6, @invoice.id
  end

  def test_it_has_customer_id
    assert_equal 7, @invoice.customer_id
  end

  def test_it_has_merchant_id
    assert_equal 8, @invoice.merchant_id
  end

  def test_it_has_status
    assert_equal :pending, @invoice.status
  end

  def test_it_has_created_at
    assert_equal Time.parse("2009-02-07"), @invoice.created_at
  end

  def test_it_has_updated_at
    assert_equal Time.parse("2014-03-15"), @invoice.updated_at
  end

end
