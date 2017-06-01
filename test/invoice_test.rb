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
      
end
