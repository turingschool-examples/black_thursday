require_relative '../test/test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test

 def test_it_exists
   i = Invoice.new({
  :id          => 6,
  :customer_id => 7,
  :merchant_id => 8,
  :status      => "pending",
  :created_at  => Time.now,
  :updated_at  => Time.now,
  })
   assert_instance_of Invoice, i
 end

  def test_it_can_return_the_invoice_id
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    assert_equal 6, i.id
  end

  def test_it_can_return_customer_id
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    assert_equal 7, i.customer_id
  end

  def test_it_can_return_merchant_id
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    assert_equal 8, i.merchant_id
  end

  def test_it_can_return_status
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    assert_equal "pending", i.status
  end

  def test_it_can_return_time_created
    time = Time.now
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => time,
      :updated_at  => time,
    })
    assert_equal time, i.created_at
  end

  def test_it_can_return_time_updated
    time = Time.new
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => time,
      :updated_at  => time,
    })
    assert_equal time, i.updated_at
  end

end
