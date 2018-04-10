require 'time'
require_relative 'test_helper'
require_relative '../lib/invoice'

# invoice test class
class InvoiceTest < Minitest::Test
  def setup
    time = Time.now
    attributes = { id: 8,
                   customer_id: 6,
                   merchant_id: 12334873,
                   status: 'shipped',
                   created_at: time,
                   updated_at: time }
    @invoice = Invoice.new(attributes)
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end
end
