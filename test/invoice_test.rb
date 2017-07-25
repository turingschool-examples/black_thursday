require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  attr_reader :i

  def setup
    @i = i = Invoice.new({id:           6,
                          customer_id:  7,
                          merchant_id:  8,
                          status:       "pending",
                          created_at:   Time.now,
                          updated_at:   Time.now,
                        })
  end

  def test_it_exists
    assert_instance_of Invoice, i
  end

  def test_it_can_see_id
    assert_equal 6, i.id
  end

  def test_it_can_see_
    assert_equal 7, i.customer_id
  end

  def test_it_can_return_merchant_id
    assert_equal 8, i.merchant_id
  end

  def test_it_can_return_status
    assert_equal "pending", i.status
  end

  def test_it_knows_when_created
    assert_instance_of Time, i.created_at
  end

  def test_it_knows_when_updated
    assert_instance_of Time, i.updated_at
  end
end
