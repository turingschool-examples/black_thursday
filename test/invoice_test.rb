require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def set_up
    invoice_info = {:id => "1",	:customer_id => "1", :merchant_id =>	"12335938", :status	=> "pending",	:created_at => "2/7/09",	:updated_at => "3/15/14"}
    Invoice.new(invoice_info, [])
  end

  def test_invoice_exists
    assert_instance_of Invoice, set_up
  end

  def test_invoice_has_id
    assert_equal 1, set_up.id
  end

  def test_invoice_has_customer_id
    assert_equal 1, set_up.customer_id
  end

  def test_invoice_has_merchant_id
    assert_equal 12335938, set_up.merchant_id
  end

  def test_invoice_status
    assert_equal "pending", set_up.status
  end

  def test_invoice_created_at
    assert_instance_of Time, set_up.created_at
  end

  def test_invoice_updated_at
    assert_instance_of Time, set_up.created_at
  end
end
