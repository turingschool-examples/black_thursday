require_relative 'test_helper'
require_relative '../lib/invoice.rb'

class InvoiceTest < Minitest::Test

  def setup
    @invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_an_id
    assert_equal 6, @invoice.id
  end

end
