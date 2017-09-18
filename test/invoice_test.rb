require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repo'
require './lib/invoice'
require './lib/merchant'
require 'pry'

class InvoiceTest < Minitest::Test
  attr_reader :invoice

  def setup
    @invoice = Invoice.new({:id => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status => "pending",
                            :created_at => Time.now.to_s,
                            :updated_at => Time.now.to_s})
  end

  def test_it_exists
    assert_instance_of Invoice, invoice
  end

  def test_it_returns_integer_id
    assert_equal 6, invoice.id
  end

  def test_it_returns_customer_id
    assert_equal 7, invoice.customer_id
  end

  def test_it_returns_merchant_id
    assert_equal 8, invoice.merchant_id
  end

  def test_it_returns_the_status
    assert_equal :pending, invoice.status
  end

  def test_it_returns_an_instance_of_time_created_at
    assert_instance_of Time, invoice.created_at
  end

  def test_it_returns_an_instance_of_time_updated_at
    assert_instance_of Time, invoice.updated_at
  end

  def test_that_it_returns_the_weekday_based_on_time
    assert_equal "Sunday", invoice.weekday_time
  end

  # def test_it_can_return_the_associated_merchant
  #   binding.pry
  #   assert_instance_of Merchant, invoice.merchant
  # end
end
