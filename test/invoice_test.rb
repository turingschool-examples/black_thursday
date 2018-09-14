require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  def test_that_it_exists
    invoice = Invoice.new({})

    assert_instance_of Invoice, invoice
  end

  def test_that_it_has_attributes
    i = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now
        })

    assert_equal 6, i.id
    assert_equal 7, i.customer_id
    assert_equal 8, i.merchant_id
    assert_equal 'pending', i.status
    assert_instance_of Time, i.created_at
    assert_instance_of Time, i.updated_at
  end


end
