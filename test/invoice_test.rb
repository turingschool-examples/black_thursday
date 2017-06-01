require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/invoice'
require 'pry'
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

   def test_it_returns_time_instance_for_created_at
     i = Invoice.new({:id => 6,
                      :customer_id => 7,
                      :merchant_id => 8,
                      :status => "pending",
                      :created_at => "2003-11-07",
                      :updated_at => "2008-03-07"},self)
      expected = "2003-11-07 00:00:00 -0700"
      assert_equal expected, i.created_at.to_s
   end

   def test_it_returns_time_instance_for_updated_at
     i = Invoice.new({:id => 6,
                      :customer_id => 7,
                      :merchant_id => 8,
                      :status => "pending",
                      :created_at => "2003-11-07",
                      :updated_at => "2008-03-07"},self)
      expected = "2008-03-07 00:00:00 -0700"
      assert_equal expected, i.updated_at.to_s
    end


end
