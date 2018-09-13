require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def setup
    @time1 = '1993-10-28 11:56:40 UTC'
    @time2 = '1993-09-29 12:45:30 UTC'
    @attributes = { id:           123,
                    customer_id:  369,
                    merchant_id:  456,
                    status:       :pending,
                    unit_price:   BigDecimal.new(12.00, 4),
                    created_at:   Time.parse(@time1),
                    updated_at:   Time.parse(@time2) }
    @invoice = Invoice.new(@attributes)
  end

  def test_it_exists
    assert_instance_of(Invoice, @invoice)
  end

  def test_it_can_show_attributes
    assert_equal(123, @invoice.id)
    assert_equal(369, @invoice.customer_id)
    assert_equal(456, @invoice.merchant_id)
    assert_equal(:pending, @invoice.status)
    assert_equal(BigDecimal.new(12.00, 4), @invoice.unit_price)
    assert_equal(Time.parse(@time1), @invoice.created_at)
    assert_equal(Time.parse(@time2), @invoice.updated_at)
  end
end
