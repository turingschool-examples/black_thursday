require_relative 'test_helper'
require_relative '../lib/invoice'
require 'time'
require 'pry'

class InvoiceTest < MiniTest::Test
  def setup
    @invoice = Invoice.new({
                      :id          => 1,
                      :customer_id => 1,
                      :merchant_id => 12335938,
                      :status      => "pending",
                      :created_at  => "2009-02-07",
                      :updated_at  => "2014-03-15"
                    })
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_an_id_number
    assert_equal 1, @invoice.id
  end

  def test_it_has_a_customer_id_number
    assert_equal 1, @invoice.customer_id
  end

  def test_it_has_a_merchant_id
    assert_equal 12335938, @invoice.merchant_id
  end

  def test_it_has_a_status
    assert_equal "pending".to_sym, @invoice.status
  end

  def test_it_has_a_created_time
    assert_equal Time.parse("2009-02-07"), @invoice.created_at
  end

  def test_it_has_a_updated_time
    assert_equal Time.parse("2014-03-15"), @invoice.updated_at
  end
end
