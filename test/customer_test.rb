require 'simplecov'
SimpleCov.start

require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'

class CustomerTest < Minitest::Test

  def test_class_exists_and_has_attributes

    c = Customer.new({
        :id => 6,
        :first_name => 'Joan',
        :last_name => 'Clarke',
        :created_at => '2012-03-27 14:54:09 UTC',
        :updated_at => '2012-03-27 14:54:09 UTC'
      })
    assert_instance_of Customer, c
    assert_equal 6, c.id
    assert_equal 'Joan', c.first_name
    assert_equal 'Clarke', c.last_name
    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), c.created_at
    assert_equal Time.parse('2012-03-27 14:54:09 UTC'), c.updated_at
  end
end
