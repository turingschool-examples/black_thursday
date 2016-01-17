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

end
