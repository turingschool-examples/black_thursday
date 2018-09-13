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
end
