require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test

  def test_new_instance
    i = Invoice.new({:id => 6,
                     :customer_id => 7,
                     :merchant_id => 8,
                     :status => "pending",
                     :created_at => Time.now,
                     :updated_at => Time.now},self)

    assert_instance_of Invoice, i
  end

  def test_it_returns_integer_id
    i = Invoice.new({:id => 6,
                     :customer_id => 7,
                     :merchant_id => 8,
                     :status => "pending",
                     :created_at => Time.now,
                     :updated_at => Time.now},self)

    assert_equal 6, i.id
  end

  def test_it_returns_customer_id
    i = Invoice.new({:id => 6,
                     :customer_id => 7,
                     :merchant_id => 8,
                     :status => "pending",
                     :created_at => Time.now,
                     :updated_at => Time.now},self)

    assert_equal 7, i.customer_id
  end

  def test_it_returns_merchant_id
    i = Invoice.new({:id => 6,
                     :customer_id => 7,
                     :merchant_id => 8,
                     :status => "pending",
                     :created_at => Time.now,
                     :updated_at => Time.now},self)

    assert_equal 8, i.merchant_id
  end

  def test_it_returns_status
    i = Invoice.new({:id => 6,
                     :customer_id => 7,
                     :merchant_id => 8,
                     :status => "pending",
                     :created_at => Time.now,
                     :updated_at => Time.now},self)

     assert_equal "pending", i.status
   end

end
