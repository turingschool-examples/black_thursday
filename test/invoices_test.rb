require_relative '../test/test_helper'
require_relative '../lib/invoices'

class InvoicesTest < Minitest::Test

  attr_reader :invoice
  def setup
    @invoice = Invoices.new(({:id => "1",
                      :customer_id => "2",
                      :merchant_id => "12335938",
                      :status => "pending",
                      :created_at => "2009-02-07",
                      :updated_at => "2014-03-15"
                      }))
  end

  def test_it_exists
    assert invoice
  end

  def test_it_has_id
    assert invoice.id
  end

  def test_it_has_customer_id
    assert invoice.customer_id
  end

  def test_it_has_merchant_id
    assert invoice.merchant_id
  end

  def test_it_has_a_status_pending
    assert invoice.status
  end

  def test_it_has_a_created_at_date
    assert invoice.created_at
  end

  def test_it_has_an_updated_at_date
    assert invoice.updated_at
  end

  def test_it_can_return_the_merchants_id
    assert_equal Fixnum, invoice.merchant_id.class
    assert_equal 12335938, invoice.merchant_id
  end

  def test_it_can_return_the_invoice_id
    assert_equal Fixnum, invoice.id.class
    assert_equal 1, invoice.id
  end

  def test_it_can_return_the_customer_id
    assert_equal Fixnum, invoice.customer_id.class
    assert_equal 2, invoice.customer_id
  end

  def test_it_can_return_the_status_of_the_shipment
    assert_equal "pending", invoice.status
  end

  def test_it_outputs_the_time_int_the_correct_format
    assert_equal "2009-02-07 00:00:00 -0700", invoice.created_at.to_s
  end

  def test_it_outputs_the_time_for_updated_at
    assert_equal "2014-03-15 00:00:00 -0600", invoice.updated_at.to_s
  end



end
