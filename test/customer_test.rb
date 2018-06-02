require_relative 'test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
  DATA = {
    id: "1",
    first_name: "Steve",
    last_name: "Malek",
    created_at: "2016-01-11 09:34:06 UTC",
    updated_at: "2007-06-04 21:35:10 UTC"
    }

  def test_it_exists
    c = Customer.new(DATA)

    assert_instance_of Customer, c
  end

  def test_it_has_attributes
    c = Customer.new(DATA)

    assert_equal 1, c.id
    assert_equal 'Steve', c.first_name
    assert_equal 'Malek', c.last_name
    assert_instance_of Time, c.created_at
    assert_instance_of Time, c.updated_at
  end
end
