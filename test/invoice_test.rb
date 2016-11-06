require_relative './test_helper'
require_relative '../lib/invoice'
require_relative '../lib/data_parser'

class InvoiceTest < Minitest::Test
  include DataParser
  def test_invoice_class_exists
    assert_instance_of Invoice, Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => :pending,
    :created_at  => Time.now,
    :updated_at  => Time.now
  })
  end

  def test_it_can_access_invoice_attributes
    i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => :pending,
    :created_at  => Time.now,
    :updated_at  => Time.now
  })
    assert_equal 6, i.id
    assert_equal 7, i.customer_id
    assert_equal 8, i.merchant_id
    assert_equal :pending, i.status
    assert_respond_to i, :created_at
    assert_respond_to i, :updated_at
  end

  def test_invoice_can_parse_rows
    file = './data/invoices.csv'
    assert_instance_of Array, parse_data(file)
  end
end
