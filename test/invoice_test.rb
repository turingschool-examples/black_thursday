require 'minitest/autorun'
require 'minitest/pride'
require 'time'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def setup
    time = Time.now
    attributes = (
      id: 8,
      customer_id: 6,
      merchant_id: 12334873,
      status: "shipped",
      created_at: time,
      updated_at: time
    )
    @invoice = Invoice.new(attributes)
  end
end
