require_relative 'test_helper'

require 'date'

require './lib/invoice'



class InvoiceTest < Minitest::Test

  def setup
    # 1,1,12335938,pending,2009-02-07,2014-03-15
    @hash = {
      :id          => "1",
      :customer_id => "1",
      :merchant_id => "12335938",
      :status      => "pending",
      :created_at  => "2009-02-07",
      :updated_at  => "2014-03-15"
    }
    @invoice = Invoice.new(@hash)
  end


  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_gets_attributes
    # -- Read Only --
    assert_equal 1, @invoice.id
    assert_equal 1, @invoice.customer_id
    assert_equal 12335938, @invoice.merchant_id
    # -- Accessible --
    # assert_instance_of Date, @invoice.created_at
    assert_instance_of Time, @invoice.created_at
    time_string = @invoice.created_at.to_s.split[0]
    assert_equal @hash[:created_at], time_string
    # assert_instance_of Date, @invoice.updated_at
    assert_instance_of Time, @invoice.updated_at
    time_string = @invoice.updated_at.to_s.split[0]
    assert_equal @hash[:updated_at], time_string
  end

end
