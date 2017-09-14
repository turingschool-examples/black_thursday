require_relative 'test_helper'
require_relative '../lib/invoice'
require 'time'
class InvoiceTest < Minitest::Test
    def test_it_exists
        i = Invoice.new({
            :id          => 6,
            :customer_id => 7,
            :merchant_id => 8,
            :status      => "pending",
            :created_at  => '2009-02-07',
            :updated_at  => '2009-02-08',
            }, 'invoice_repository')

        assert_instance_of Invoice, i 
    end 

    def test_it_can_display_attributes
        i = Invoice.new({
            :id          => 6,
            :customer_id => 7,
            :merchant_id => 8,
            :status      => "pending",
            :created_at  => '2009-02-07',
            :updated_at  => '2009-02-08',
            }, 'invoice_repository')

        assert_equal 6, i.id 
        assert_equal 7, i.customer_id
        assert_equal 8, i.merchant_id
        assert_equal 'pending', i.status
        assert_equal Time.parse('2009-02-07'), i.created_at
        assert_equal Time.parse('2009-02-08'), i.updated_at  
    end

    def test_

end 