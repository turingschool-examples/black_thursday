require_relative 'test_helper'
require 'time'
require_relative './../lib/invoice'
require_relative './../lib/sales_engine'

class InvoiceTest < Minitest::Test

  def test_it_exists
    created_at = "2015-03-13"
    updated_at = "2015-04-05"

    invoice = Invoice.new(
      {:id         => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => created_at,
      :updated_at  => updated_at}
    )

    assert_instance_of Invoice, invoice
  end
end
