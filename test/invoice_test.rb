require_relative './test_helper'
require_relative '../lib/invoice'
require 'bigdecimal'

class InvoiceTest < Minitest::Test

    def test_it_exists
      i = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now
      })
      assert_instance_of Invoice, i
    end

    def test_it_has_attributes
      i = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now
      })
      assert_equal 6, i.id
      assert_equal 7, i.customer_id
      assert_equal 8, i.merchant_id
      assert_equal :pending, i.status
    end

    def test_it_returns_created_at
      i = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now
      })
      assert_instance_of Time, i.created_at
    end

    def test_it_returns_updated_at
      i = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now
      })
      assert_instance_of Time, i.updated_at
    end

end
