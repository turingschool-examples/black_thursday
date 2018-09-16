require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'time'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceTest<Minitest::Test

  def setup
    @invoice = Invoice.new({:id => 1,
                            :customer_id => 1,
                            :merchant_id => 12335938,
                            :status => "pending",
                            :created_at => Time.now,
                            :updated_at => Time.now}
                          )

  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_attributes
    assert_equal 1, @invoice.id
    assert_equal 1, @invoice.customer_id
    assert_equal 12335938, @invoice.merchant_id
    assert_equal "pending", @invoice.status
 #i chose to not test the time attributes, becuse i have
 #literally no idea how to do that
 binding.pry
  end

end
