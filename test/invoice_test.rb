require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class InvoiceTest < Minitest::Test

  def test_class_exist
    assert Invoice
  end

  def setup
    i = Invoice.new({
                :id          => 6,
                :customer_id => 7,
                :merchant_id => 8,
                :status      => :pending,
                :created_at  => "2009-02-07",
                :updated_at  => "2014-03-15",
                                          })
  end

  def test_that_id_method_exist
    assert Invoice.method_defined? :id
  end

  def test_that_customer_id_method_exist
    assert Invoice.method_defined? :customer_id
  end

  def test_that_merchant_id_method_exist
    assert Invoice.method_defined? :merchant_id
  end

  def test_that_status_method_exist
    assert Invoice.method_defined? :status
  end

  def test_that_created_at_method_exist
    assert Invoice.method_defined? :created_at
  end

  def test_that_updated_at_method_exist
    assert Invoice.method_defined? :updated_at
  end

  def test_that_item_can_call_all_its_attributes
    invoice  = setup

    assert_equal         6, invoice.id
    assert_equal         7, invoice.customer_id
    assert_equal         8, invoice.merchant_id
    assert_equal  :pending, invoice.status
    assert_equal Time.parse("2009-02-07"), invoice.created_at
    assert_equal Time.parse("2014-03-15"), invoice.updated_at
  end

  def test_find_by_id

  end

end
