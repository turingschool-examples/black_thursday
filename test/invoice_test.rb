require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test

  attr_reader :invoice

  def setup
    @invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      }, self)
  end

  def test_it_exists
    @invoice

    assert_instance_of Invoice, actual
  end

  def test_it_contains_all_invoice_data
    actual = @invoice.all
    expected = @all_invoice_data

    assert_equal expected, actual
  end
end
