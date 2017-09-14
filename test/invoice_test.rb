require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
require 'pry'

class InvoiceTest < MiniTest::Test

  def test_it_exist
    invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    assert_instance_of Invoice, invoice
  end

  def test_does_it_have_id
    invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    assert_equal 6, invoice.id
  end
  
  def test_does_it_have_customer_id
    invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    assert_equal 7, invoice.customer_id
  end
  
  def test_does_it_have_merchant_id
    invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    assert_equal 8, invoice.merchant_id
  end
  
  def test_does_it_have_status
    invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    assert_equal :pending, invoice.status
  end
  
  def test_does_it_have_created_at_time
    invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    assert_instance_of Time, invoice.created_at
  end
  
  def test_does_it_have_updated_at_time
    invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    assert_instance_of Time, invoice.updated_at
  end
  
end
