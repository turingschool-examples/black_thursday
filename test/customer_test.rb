require_relative'test_helper'
require'./lib/customer'

class CustomerTest < Minitest::Test
	attr_reader :c

	def setup
		@c = Customer.new({
			:id => 6,
			:first_name => "Joan",
			:last_name => "Clarke",
			:created_at => Time.now.to_s,
			:updated_at => Time.now.to_s
		}, nil)
	end

	def test_all
		assert_equal 6, c.id
		assert_equal "Joan", c.first_name
		assert_equal "Clarke", c.last_name
		assert_instance_of Time, c.created_at
		assert_instance_of Time, c.updated_at
	end

end