require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def test_it_exists
    invoice = Invoice.new({:id => "4", :customer_id => "7", :merchant_id => "12337139", :created_at => "2015-03-13", :updated_at => "2015-04-05"})

    assert_instance_of Invoice, invoice
  end

  def test_merchant_id_is_correct_integer
    invoice = Invoice.new({:id => "4", :customer_id => "7", :merchant_id => "12337139", :created_at => "2015-03-13", :updated_at => "2015-04-05"})

    assert_equal 12337139, invoice.merchant_id
  end

  def test_id_returns_correct_integer
    invoice = Invoice.new({:id => "4", :customer_id => "7", :merchant_id => "12337139", :created_at => "2015-03-13", :updated_at => "2015-04-05"})

    assert_equal 4, invoice.id
  end

  def test_customer_id_is_correct_integer
    invoice = Invoice.new({:id => "4", :customer_id => "7", :merchant_id => "12337139", :created_at => "2015-03-13", :updated_at => "2015-04-05"})

    assert_equal 7, invoice.customer_id
  end

  def test_time_returns_time_exists
    invoice = Invoice.new({:id => "4", :customer_id => "7", :merchant_id => "12337139", :created_at => "2015-03-13", :updated_at => "2015-04-05"})

    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
  end

end
