require_relative './test_helper'
require './lib/invoice'
require 'time'
require 'bigdecimal'
require 'mocha/minitest'

class InvoiceTest < Minitest::Test
  def test_it_exists_and_has_attributes
    repo = mock
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }, repo)


    invoice_test_created_at = i.created_at.strftime("%d/%m/%Y")
    invoice_test_updated_at = i.updated_at.strftime("%d/%m/%Y")

    assert_instance_of Invoice, i
    assert_equal 6, i.id
    assert_equal 7, i.customer_id
    assert_equal 8, i.merchant_id
    assert_equal "pending", i.status
    assert_equal Time.now.strftime("%d/%m/%Y"), invoice_test_created_at
    assert_equal Time.now.strftime("%d/%m/%Y"), invoice_test_updated_at
  end
end