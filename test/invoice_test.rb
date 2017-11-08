require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < MiniTest::Test
  attr_reader :i

  def setup
    @i = Invoice.new({:id         => 6,
                     :customer_id => 7,
                     :merchant_id => 8,
                     :status      => "pending",
                     :created_at  => "2017-11-05",
                     :updated_at  => "2017-11-02"
                    })
  end

  def test_invoice_exists
    assert_instance_of Invoice, i
  end

  def test_invoice_has_attributes
    assert_equal 6, i.id
    assert_equal 7, i.customer_id
    assert_equal 8, i.merchant_id
    assert_equal :pending, i.status
    assert_equal "2017-11-05 00:00:00 -0600", i.created_at.to_s
    assert_equal "2017-11-02 00:00:00 -0600", i.updated_at.to_s
  end

end
