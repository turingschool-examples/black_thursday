require_relative './test_helper'
require_relative '../lib/customer'
require 'bigdecimal'

class CustomerTest < Minitest::Test

      def test_it_exists
        c = Customer.new({
          id: 6,
          first_name: 'Joan',
          last_name: 'Clarke',
          created_at: Time.now,
          updated_at: Time.now
        })
        assert_instance_of Customer, c
      end

      def test_it_has_attributes
        c = Customer.new({
          id: 6,
          first_name: 'Joan',
          last_name: 'Clarke',
          created_at: Time.parse('2016-01-11 09:34:06 UTC',),
          updated_at: Time.parse('2007-06-04 21:35:10 UTC'),
        })
        assert_equal 6, c.id
        assert_equal 'Joan', c.first_name
        assert_equal 'Clarke', c.last_name
      end

      def test_it_returns_created_at
        c = Customer.new({
          id: 6,
          first_name: 'Joan',
          last_name: 'Clarke',
          created_at: Time.now,
          updated_at: Time.now
        })
        assert_instance_of Time, c.created_at
      end

      def test_it_returns_updated_at
        c = Customer.new({
          id: 6,
          first_name: 'Joan',
          last_name: 'Clarke',
          created_at: Time.now,
          updated_at: Time.now
        })
        assert_instance_of Time, c.updated_at
      end

end
