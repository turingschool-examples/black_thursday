require './test/test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test
  def invoice_test_setup
    [ Invoice.new({  :id          => "998",
                     :customer_id => "192",
                     :merchant_id => "12336161",
                     :status      => "shipped",
                     :created_at  => "2009-06-19",
                     :updated_at  => "2012-03-07" }),

      Invoice.new({  :id          => "334",
                     :customer_id => "69",
                     :merchant_id => "12334832",
                     :status      => "shipped",
                     :created_at  => "2007-07-08",
                     :updated_at  => "2015-01-16" }),

      Invoice.new({  :id          => "445",
                     :customer_id => "85",
                     :merchant_id => "12334742",
                     :status      => "returned",
                     :created_at  => "2007-10-21",
                     :updated_at  => "2008-08-29" }) ]

  end

  def test_it_has_an_id
    invoice = invoice_test_setup

    assert_equal 998, invoice[0].id
    assert_equal 334, invoice[1].id
    assert_equal 445, invoice[2].id
  end

  def test_it_has_a_customer_id
  end


#
# i = Invoice.new({
#   :id          => 6,
#   :customer_id => 7,
#   :merchant_id => 8,
#   :status      => "pending",
#   :created_at  => Time.now,
#   :updated_at  => Time.now,
# })
end
