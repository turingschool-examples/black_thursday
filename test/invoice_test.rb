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

  def test_it_has_a_merchant_id
    assert_equal 8, @in.merchant_id
  end

  def test_it_has_a_status
    assert_equal 'pending', @in.status
  end

  def test_it_is_created_at_a_time
    assert_equal '2016-01-11 09:34:06 UTC', @in.created_at
  end

  def test_it_is_updated_at_a_time
    assert_equal '2007-06-04 21:35:10 UTC', @in.updated_at
  end




end
