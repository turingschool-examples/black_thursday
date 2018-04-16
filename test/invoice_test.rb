require 'time'
require_relative 'test_helper'
require_relative '../lib/elementals/invoice'

# invoice test class
class InvoiceTest < Minitest::Test
  def setup
    @time = Time.now
    attributes = { id: 8,
                   customer_id: 6,
                   merchant_id: 12334873,
                   status: 'shipped',
                   created_at: @time,
                   updated_at: @time }
    @invoice = Invoice.new(attributes)
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_an_id
    assert_equal 8, @invoice.id
  end

  def test_it_has_customer_id
    assert_equal 6, @invoice.customer_id
  end

  def test_it_has_merchant_id
    assert_equal 12334873, @invoice.merchant_id
  end

  def test_it_has_status
    assert_equal :shipped, @invoice.status
  end

  def test_it_has_created_at
    assert_equal @time, @invoice.created_at
  end

  def test_it_has_updated_at
    assert_equal @time, @invoice.updated_at
  end
end
