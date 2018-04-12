require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  attr_reader :invoice

  def setup
    @invoice = Invoice.new({ :id => 5,
                              :customer_id => 6,
                              :merchant_id => 7,
                              :status => "pending",
                              :created_at => "2018-04-10",
                              :updated_at => "2018-04-10"
                                }, self)
  end

  def test_it_exists
    assert_instance_of Invoice, invoice
  end

  def test_it_retunrs_the_integer_id
    assert_equal 5, invoice.id
  end

  def test_it_returns_a_customer_id
    assert_equal 6, invoice.customer_id
  end

  def test_it_returns_the_status
    assert_equal "pending", invoice.status
  end

  def test_it_has_created_at
    assert_equal "2018-04-10", invoice.created_at
  end

  def test_it_has_updated_at
    assert_equal "2018-04-10", invoice.updated_at
  end
end
