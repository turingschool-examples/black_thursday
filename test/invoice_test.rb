require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test

  def setup
    @i1 = Invoice.new({"id"        => '1',
                  "customer_id" => '34',
                  "merchant_id" => '11',
                  "status"      => "pending",
                  "created_at"  => '1993-09-29 11:56:40 UTC',
                  "updated_at"  => '1993-09-29 11:56:40 UTC'
                 })

  end

  def test_it_exists

    assert_instance_of Invoice, @i1
  end

  def test_initialize_can_format_data

        assert_equal 1, @i1.id
        assert_equal 34, @i1.customer_id
        assert_equal 11, @i1.merchant_id
        assert_equal "pending", @i1.status
        assert_instance_of Time, @i1.created_at
        assert_instance_of Time, @i1.updated_at
  end
end
