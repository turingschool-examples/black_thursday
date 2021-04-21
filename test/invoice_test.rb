require_relative 'test_helper'
require_relative '../lib/invoice.rb'

class InvoiceTest <  Minitest::Test
  def test_it_exists
    i = Invoice.new({:id => 6, :customer_id => 7, :merchant_id => 2,
      :status => "pending", :created_at => Time.now, :updated_at => Time.now
      }, self)
    assert_instance_of Invoice, i
  end

  def test_it_has_attributes
    i = Invoice.new({:id => 6, :customer_id => 7, :merchant_id => 2,
      :status => "pending", :created_at => Time.now, :updated_at => Time.now
      }, self)
    assert_equal 6, i.id
    assert_equal 7, i.customer_id
    assert_equal 2, i.merchant_id
    assert_equal :pending, i.status
  end

end
