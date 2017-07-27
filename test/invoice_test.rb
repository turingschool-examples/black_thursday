require './lib/invoice'
require './test/test_helper'


class InvoiceTest < Minitest::Test
  def test_it_exists
    invoice = Invoice.new(1, 54321, :returned,
                          "2016-01-11 09:34:06 UTC",
                          "2016-01-11 09:34:06 UTC",
                          12345, self)

    assert_instance_of Invoice, invoice
  end

  def test_it_is_created_with_state
    invoice = Invoice.new(1, 54321, :returned,
                          "2016-01-11 09:34:06 UTC",
                          "2016-01-11 09:34:06 UTC",
                          12345, self)

    assert_equal 1, invoice.id
    assert_equal 54321, invoice.customer_id
    assert_equal :returned, invoice.status
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), invoice.created_at
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), invoice.updated_at
    assert_equal 12345, invoice.merchant_id
  end
end
