require "./test/test_helper"
require "./lib/invoice"

class InvoiceTest < Minitest::Test

  attr_reader :invoice

  def setup
    csv_hash = {id: 6,
                custom_id: 7,
                merchant_id: 8,
                status: "pending",
                created_at: "2016-01-11 09:34:06 UTC",
                updated_at: "2007-06-04 21:35:10 UTC"}
    @invoice = Invoice.new('fake_ir', csv_hash)
  end

  def test_it_exists
    assert_instance_of Invoice, invoice
  end

  def test_invoice_has_id
    assert_equal 6, invoice.id
  end

  def test_invoice_has_custom_id
    assert_equal 7, invoice.custom_id
  end

  def test_invoice_has_merchant_id
    assert_equal 8, invoice.merchant_id
  end

  def test_invoice_has_status
    assert_equal "pending", invoice.status
  end

  def test_invoice_has_created_at_time
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), invoice.created_at
  end

  def test_invoice_has_updated_at_time
    assert_equal Time.parse("2007-06-04 21:35:10 UTC"), invoice.updated_at
  end

end
