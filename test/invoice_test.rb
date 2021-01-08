require 'simplecov'
SimpleCov.start

require 'time'
require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
    def setup
      @invoice = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => "2015-03-13", #Time.now,
        :updated_at  => "2015-04-05" #Time.now,
      }, "self")
    end

  def test_it_has_readable_attributes
    assert_instance_of Invoice, @invoice
    assert_equal 6, @invoice.id
    assert_equal 7, @invoice.customer_id
    assert_equal 8, @invoice.merchant_id
    assert_equal :pending, @invoice.status
    assert_equal "2015-03-13 00:00:00 -0600", @invoice.created_at.to_s
    assert_equal "2015-04-05 00:00:00 -0600", @invoice.updated_at.to_s
  end
end
