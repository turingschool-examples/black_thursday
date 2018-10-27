require_relative './helper'
require_relative '../lib/invoice'
class InvoiceTest < Minitest::Test
  def setup
  @in = Invoice.new( {
                      :id          => 6,
                      :customer_id => 7,
                      :merchant_id => 8,
                      :status      => 'pending',
                      :created_at  => '2016-01-11 09:34:06 UTC',
                      :updated_at  => '2007-06-04 21:35:10 UTC'
                    } )
  end
  def test_invoice_exists
    assert_instance_of Invoice, @in
  end

  def test_item_has_id
    assert_equal 6, @in.id
  end

  def test_it_has_customer_id
    assert_equal 7, @in.customer_id
  end







end
