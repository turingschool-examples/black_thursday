require_relative 'test_helper'

require './lib/invoice'


class InvoiceTest < Minitest::Test

  def setup
    @hash = {
      :id => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status => "pending",
      :created_at => Time.now,
      :updated_at => Time.now
    }

    @invoice = Invoice.new(@hash)
  end


  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_gets_attributes
    # -- Read Only --
    assert_equal @hash[:id], @invoice.id
    assert_equal @hash[:customer_id], @invoice.customer_id
    assert_equal @hash[:merchant_id], @invoice.merchant_id
    # TO DO - Assert we cannot write to these values https://docs.ruby-lang.org/en/2.1.0/MiniTest/Assertions.html
    # -- Accessible --
    assert_equal @hash[:created_at], @invoice.created_at
    assert_equal @hash[:updated_at], @invoice.updated_at
    # TO DO - Assert we can write to these values
  end



end
